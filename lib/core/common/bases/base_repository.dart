import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_codebase_clean/core/error/network_exceptions.dart';
import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/features/app/presentation/bloc/app_cubit.dart';
import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
abstract class BaseRepository {
  //'count' to handle for UnauthorizedRequest with multiple api case
  // Avoid show Toast Unautherized many times.

  FormData wrapFormData<T>(T source) {
    return FormData.fromMap({
      'source': MultipartFile.fromString(jsonEncode(source),
          contentType: MediaType.parse('application/json'))
    });
  }

  FormData wrapMapFormData(Map<String, dynamic> body) {
    final Map<String, dynamic> request = body.map((key, value) => MapEntry(
        key,
        value is List<File>
            ? value.map((e) => MultipartFile.fromFileSync(e.path)).toList()
            : value is File
                ? MultipartFile.fromFileSync(value.path)
                : MultipartFile.fromString(jsonEncode(value),
                    contentType: MediaType.parse('application/json'))));
    return FormData.fromMap(request);
  }

  Stream<Uint8List> wrapBinary(File file) {
    final binary = file.openRead().cast<Uint8List>();
    return binary;
  }

  ApiResult<T> handleErrorApi<T>(dynamic e,
      {String tag = '', forceLogout = true}) {
    if (e is String) {
      return ApiResult.failure(error: e);
    } else {
      final NetworkExceptions exceptions = NetworkExceptions.getDioException(e);
      if (forceLogout && exceptions is UnauthorizedRequest) {
        final AppCubit cubit = GetIt.I<AppCubit>();
        cubit.logout(
            errorMessage: NetworkExceptions.getErrorMessage(exceptions));
      }
      return ApiResult.failure(error: NetworkExceptions.getErrorMessage(exceptions));
    }
  }
}
