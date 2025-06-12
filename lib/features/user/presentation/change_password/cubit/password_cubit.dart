import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_cubit.freezed.dart';
part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(const PasswordStateInit());

  bool? isCurrentPasswordHide = true;
  bool? isNewPasswordHide = true;
  bool? isConfirmNewPasswordHide = true;

  void showHidePassword() {
    emit(const PasswordStateInit());
    isCurrentPasswordHide = !(isCurrentPasswordHide ?? false);
    emit(const PasswordStateShowHide());
  }

  void showHideNewPassword() {
    emit(const PasswordStateInit());
    isNewPasswordHide = !(isNewPasswordHide ?? false);
    emit(const PasswordStateShowHide());
  }

  void showHideConfirmNewPassword() {
    emit(const PasswordStateInit());
    isConfirmNewPasswordHide = !(isConfirmNewPasswordHide ?? false);
    emit(const PasswordStateShowHide());
  }
}
