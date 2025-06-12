import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  /// Controller
  final _conCurrentPassword = TextEditingController();
  final _conNewPassword = TextEditingController();
  final _conConfirmPassword = TextEditingController();

  /// Focus Node
  final _fnCurrentPassword = FocusNode();
  final _fnNewPassword = FocusNode();
  final _fnConfirmPassword = FocusNode();

  /// Global key
  final _keyForm = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  void resetForm() {
    setState(() {
      _conCurrentPassword.clear();
      _conNewPassword.clear();
      _conConfirmPassword.clear();
    });
    _scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: CustomAppBar(title: Strings.of(context)!.changePassword),
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) => switch (state) {
          ChangePasswordStateLoading() => context.show(),
          ChangePasswordStateSuccess(:final data) => (() {
              context.dismiss();
              data.meta?.message.toString().toToastSuccess(context);
              resetForm();
              context.read<AuthCubit>().logout();
              context.goNamed(Routes.login.name);
            })(),
          ChangePasswordStateFailure(:final type, :final message) => (() {
              if (type is UnauthorizedFailure) {
                Strings.of(context)!.expiredToken.toToastError(context);
                context.goNamed(Routes.login.name);
              } else {
                context.dismiss();
                message.toToastError(context);
              }
            })(),
          _ => {},
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FormSection(
              formKey: _keyForm,
              currentPasswordController: _conCurrentPassword,
              newPasswordController: _conNewPassword,
              confirmPasswordController: _conConfirmPassword,
              currentPasswordFocus: _fnCurrentPassword,
              newPasswordFocus: _fnNewPassword,
              confirmPasswordFocus: _fnConfirmPassword,
            ),
          ),
        ),
      ),
    );
  }
}
