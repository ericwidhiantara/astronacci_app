import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final FocusNode currentPasswordFocus;
  final FocusNode newPasswordFocus;
  final FocusNode confirmPasswordFocus;

  const FormSection({
    super.key,
    required this.formKey,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.currentPasswordFocus,
    required this.newPasswordFocus,
    required this.confirmPasswordFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpacerV(value: Dimens.size20),
          PasswordFieldSection(
            hint: "Kata Sandi Saat Ini",
            controller: currentPasswordController,
            focusNode: currentPasswordFocus,
            nextFocusNode: newPasswordFocus,
            validator: (value) => value != null
                ? (value.length < 6
                    ? Strings.of(context)!.errorPasswordLength
                    : null)
                : null,
            isObscured: (state) =>
                context.read<PasswordCubit>().isCurrentPasswordHide ?? false,
            onToggleVisibility: () =>
                context.read<PasswordCubit>().showHidePassword(),
          ),
          PasswordFieldSection(
            hint: "Kata Sandi Baru",
            controller: newPasswordController,
            focusNode: newPasswordFocus,
            nextFocusNode: confirmPasswordFocus,
            validator: (value) => value != null
                ? (value.length < 6
                    ? Strings.of(context)!.errorPasswordLength
                    : null)
                : null,
            isObscured: (state) =>
                context.read<PasswordCubit>().isNewPasswordHide ?? false,
            onToggleVisibility: () =>
                context.read<PasswordCubit>().showHideNewPassword(),
          ),
          PasswordFieldSection(
            hint: "Konfirmasi Kata Sandi",
            controller: confirmPasswordController,
            focusNode: confirmPasswordFocus,
            validator: (value) {
              if (value != null) {
                if (value.length < 6) {
                  return Strings.of(context)!.errorPasswordLength;
                } else if (value != newPasswordController.text) {
                  return Strings.of(context)!.errorPasswordNotMatch;
                }
              }
              return null;
            },
            isObscured: (state) =>
                context.read<PasswordCubit>().isConfirmNewPasswordHide ?? false,
            onToggleVisibility: () =>
                context.read<PasswordCubit>().showHideConfirmNewPassword(),
          ),
          SpacerV(value: Dimens.size20),
          Button(
            title: "Kirim",
            color: Theme.of(context).extension<CustomColor>()?.primary,
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                context.read<ChangePasswordCubit>().changePassword(
                      PostChangePasswordParams(
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text,
                      ),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
