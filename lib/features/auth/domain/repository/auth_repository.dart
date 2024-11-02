import 'package:flutter_codebase_clean/core/common/bases/base_repository.dart';
import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository extends BaseRepository {
  Future<ApiResult<Auth>> login(LoginRequest request);
}
