import 'package:flutter_codebase_clean/core/common/bases/base_repository.dart';
import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_codebase_clean/features/profile/domain/entities/profile_entity.dart';
abstract class ProfileRepository extends BaseRepository {
  Future<ApiResult<ProfileEntity>> getProfile();
}
