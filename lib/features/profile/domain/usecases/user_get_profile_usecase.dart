import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/core/usecase/usecase.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_codebase_clean/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_codebase_clean/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_codebase_clean/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';


@Injectable()
class UserGetProfileUseCase implements NoInputUseCase{
  final ProfileRepository profileRepository;
  const UserGetProfileUseCase(this.profileRepository);

  @override
  Future<ApiResult<ProfileEntity>> call() async {
    return await profileRepository.getProfile();
  }
}
