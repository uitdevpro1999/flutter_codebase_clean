import 'package:dio/dio.dart';
import 'package:flutter_codebase_clean/core/common/bases/model/base_response.dart';
import 'package:flutter_codebase_clean/core/network/endpoint/endpoint.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/response/auth_response.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api_services.g.dart';

@RestApi()
abstract class AuthApiServices {
  factory AuthApiServices(Dio dio, {String baseUrl}) = _AuthApiServices;
  @POST(Endpoint.login)
  Future<BaseResponse<AuthResponse>> login(@Body() LoginRequest request);
}
