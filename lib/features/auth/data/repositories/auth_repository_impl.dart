import 'package:flutter/foundation.dart';
import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_codebase_clean/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSources _src;
  AuthRepositoryImpl(this._src,);

  @override
  Future<ApiResult<Auth>> login(LoginRequest request) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
