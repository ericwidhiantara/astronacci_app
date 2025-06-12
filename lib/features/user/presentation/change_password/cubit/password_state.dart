part of 'password_cubit.dart';

@freezed
sealed class PasswordState with _$PasswordState {
  const factory PasswordState.showHide() = PasswordStateShowHide;

  const factory PasswordState.init() = PasswordStateInit;
}
