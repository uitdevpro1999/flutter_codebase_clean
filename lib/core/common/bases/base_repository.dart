import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_codebase_clean/core/common/bases/model/base_response.dart';
import 'package:flutter_codebase_clean/core/constants/constants.dart';
import 'package:flutter_codebase_clean/core/error/network_exceptions.dart';
import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/features/main_application/app/presentation/bloc/app_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

abstract class BaseRepository {
  //'count' to handle for UnauthorizedRequest with multiple api case
  // Avoid show Toast Unautherized many times.

  FormData wrapFormData<T>(T source) {
    return FormData.fromMap(
        {'source': MultipartFile.fromString(jsonEncode(source), contentType: MediaType.parse('application/json'))});
  }

  FormData wrapMapFormData(Map<String, dynamic> body) {
    final Map<String, dynamic> request = body.map((key, value) => MapEntry(
        key,
        value is List<File>
            ? value.map((e) => MultipartFile.fromFileSync(e.path)).toList()
            : value is File
                ? MultipartFile.fromFileSync(value.path)
                : MultipartFile.fromString(jsonEncode(value), contentType: MediaType.parse('application/json'))));
    return FormData.fromMap(request);
  }

  Stream<Uint8List> wrapBinary(File file) {
    final binary = file.openRead().cast<Uint8List>();
    return binary;
  }

  ApiResult<T> _handleErrorApi<T>(dynamic e, {String tag = '', forceLogout = true}) {
    if (e is String) {
      return ApiResult.failure(error: e);
    } else {
      final NetworkExceptions exceptions = NetworkExceptions.getDioException(e);
      if (forceLogout && exceptions is UnauthorizedRequest) {
        final AppCubit cubit = GetIt.I<AppCubit>();
        cubit.logout(errorMessage: NetworkExceptions.getErrorMessage(exceptions));
      }
      return ApiResult.failure(error: NetworkExceptions.getErrorMessage(exceptions));
    }
  }

  Future<ApiResult<T>> handleApiResponse<T>(final Future<dynamic> Function() apiCall) async {
    try {
      final response = await apiCall();
      if (response is BaseResponse) {
        if (response.code != Consts.successCode) {
          return _handleErrorApi(response.message);
        }
        return ApiResult.success(data: response.data);
      }
      return ApiResult.success(data: response);
    } catch (e) {
      return _handleErrorApi(e);
    }
  }

  Future<ApiResult<T>> handleGraphQLResponse<T>(
    Future<QueryResult> Function() gqlCall,
    T Function(Map<String, dynamic> data) fromJson, // dùng để convert kết quả
  ) async {
    try {
      final result = await gqlCall();

      if (result.hasException) {
        final exception = result.exception!;
        final message = exception.graphqlErrors.isNotEmpty
            ? exception.graphqlErrors.map((e) => e.message).join(", ")
            : exception.linkException?.toString() ?? "Unknown error";

        return ApiResult.failure(error: message);
      }

      final data = result.data;
      if (data == null) {
        return ApiResult.failure(error: "Empty data response");
      }

      return ApiResult.success(data: fromJson(data));
    } catch (e) {
      return ApiResult.failure(error: e.toString());
    }
  }
}
