import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_codebase_clean/core/common/bases/enum/auth_status.dart';
import 'package:flutter_codebase_clean/core/local_storage/share_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'app_cubit.freezed.dart';
part 'app_state.dart';

@LazySingleton()
class AppCubit extends Cubit<AppState> {
  final AppPreferences _appPreferences;
  bool get isLoggedIn => _appPreferences.isLoggedIn;

  AppCubit(this._appPreferences,) : super(const AppState());

  /// Xử lý logic khi mở app
  Future<void> openApp() async {
    Future.delayed(
      const Duration(milliseconds: 3500),
      () async {
        if (isLoggedIn) {
          emit(state.copyWith(authStatus: AuthStatus.authenticated));
          return;
        }
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
      },
    );
  }

  void onLoggedIn() {
    emit(state.copyWith(authStatus: AuthStatus.authenticated));
  }

  Future<void> logout({String? errorMessage}) async {
    emit(state.copyWith(authStatus: AuthStatus.unknown));
    await _appPreferences.logout();
    emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
  }

  void navigateResetToSignIn() {
    emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
  }
}
