import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordFieldSection extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String? Function(String?) validator;
  final bool Function(PasswordState) isObscured;
  final VoidCallback onToggleVisibility;

  const PasswordFieldSection({
    super.key,
    required this.hint,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.validator,
    required this.isObscured,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordCubit, PasswordState>(
      builder: (_, state) {
        return TextF(
          autofillHints: const [AutofillHints.password],
          key: Key(hint.toLowerCase().replaceAll(' ', '_')),
          curFocusNode: focusNode,
          nextFocusNode: nextFocusNode,
          textInputAction: nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          textCapitalization: TextCapitalization.none,
          controller: controller,
          keyboardType: TextInputType.text,
          obscureText: isObscured(state),
          hintText: '••••••••••••',
          maxLine: 1,
          hint: hint,
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: onToggleVisibility,
            icon: Icon(
              isObscured(state) ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          validator: validator,
        );
      },
    );
  }
}
