import 'package:flutter_codebase_clean/core/network/api/api_result.dart';
import 'package:flutter_codebase_clean/core/usecase/usecase.dart';
import 'package:flutter_codebase_clean/features/auth/data/models/request/login_request.dart';
import 'package:flutter_codebase_clean/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_codebase_clean/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';


@Injectable()
class UserLoginUseCase implements UseCase<dynamic, LoginRequest> {
  final AuthRepository authRepository;
  const UserLoginUseCase(this.authRepository);

  @override
  Future<ApiResult<Auth>> call(LoginRequest params) async {
    return await authRepository.login(params);
  }
}
