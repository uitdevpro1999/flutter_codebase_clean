import 'package:flutter/foundation.dart';
import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_codebase_clean/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_codebase_clean/features/profile/data/datasources/profile_remote_data_sources.dart';
import 'package:flutter_codebase_clean/features/profile/data/models/response/profile_response.dart';
import 'package:flutter_codebase_clean/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_codebase_clean/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSources _src;
  ProfileRepositoryImpl(
    this._src,
  );

  @override
  Future<ApiResult<ProfileEntity>> getProfile() {
    return handleGraphQLResponse(() => _src.getProfile(), (js) => ProfileResponse.fromJson(js).toEntity());
  }
}
