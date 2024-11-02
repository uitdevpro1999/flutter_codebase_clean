part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(AuthStatus.unknown) authStatus,
  }) = _AppState;
}
