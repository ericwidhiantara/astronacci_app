part of 'logout_cubit.dart';

@freezed
sealed class LogoutState with _$LogoutState {
  const factory LogoutState.loading() = LogoutStateLoading;

  const factory LogoutState.success(GeneralAPIEntity? data) =
      LogoutStateSuccess;

  const factory LogoutState.failure(Failure type, String message) =
      LogoutStateFailure;

  const factory LogoutState.empty() = LogoutStateEmpty;
}
