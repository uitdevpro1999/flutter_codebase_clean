import 'package:dio/dio.dart';
import 'package:flutter_codebase_clean/core/common/bases/model/base_response.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'auth_remote_services.dart';

abstract class AuthRemoteDataSources {
  Future<BaseResponse<AuthResponse>> login(LoginRequest request);
}

@Injectable(as: AuthRemoteDataSources)
class AuthRemoteDataSourcesImpl extends AuthRemoteDataSources {
  final AuthRemoteServices _source;
  AuthRemoteDataSourcesImpl(Dio dio) : _source = AuthRemoteServices(dio);

  @override
  Future<BaseResponse<AuthResponse>> login(LoginRequest request) {
    return _source.login(request);
  }

}
