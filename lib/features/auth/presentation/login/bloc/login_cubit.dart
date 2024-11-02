import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_codebase_clean/features/app/presentation/bloc/app_cubit.dart';
import 'package:flutter_codebase_clean/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@Injectable()
class LoginCubit extends Cubit<LoginState> {
  LoginCubit( this._userLogin,) : super(LoginState());
  final UserLoginUseCase _userLogin;
}
