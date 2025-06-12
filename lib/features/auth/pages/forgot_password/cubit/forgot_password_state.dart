part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.loading() = ForgotPasswordStateLoading;

  const factory ForgotPasswordState.success(GeneralAPIEntity? data) =
      ForgotPasswordStateSuccess;

  const factory ForgotPasswordState.failure(String message) =
      ForgotPasswordStateFailure;

  const factory ForgotPasswordState.init() = ForgotPasswordStateInit;
}
