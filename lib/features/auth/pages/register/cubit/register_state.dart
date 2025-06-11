part of 'register_cubit.dart';

@freezed
sealed class RegisterState with _$RegisterState {
  const factory RegisterState.loading() = RegisterStateLoading;

  const factory RegisterState.success(RegisterEntity? data) =
      RegisterStateSuccess;

  const factory RegisterState.failure(
    Failure? type,
    RegisterErrorEntity? errors,
    String message,
  ) = RegisterStateFailure;

  const factory RegisterState.showHide() = RegisterStateShowHide;

  const factory RegisterState.init() = RegisterStateInit;
}
