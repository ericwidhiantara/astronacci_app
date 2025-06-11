part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthStateLoading;

  const factory AuthState.success(LoginEntity? data) = AuthStateSuccess;

  const factory AuthState.failure(String message) = AuthStateFailure;

  const factory AuthState.showHide() = AuthStateShowHide;

  const factory AuthState.init() = AuthStateInit;
}
