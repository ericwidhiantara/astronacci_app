part of 'change_password_cubit.dart';

@freezed
sealed class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.loading() = ChangePasswordStateLoading;

  const factory ChangePasswordState.success(GeneralAPIEntity data) =
      ChangePasswordStateSuccess;

  const factory ChangePasswordState.failure(Failure type, String message) =
      ChangePasswordStateFailure;

  const factory ChangePasswordState.empty() = ChangePasswordStateEmpty;
}
