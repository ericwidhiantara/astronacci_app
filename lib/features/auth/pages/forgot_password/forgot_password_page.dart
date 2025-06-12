import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  /// Controller
  final _conEmail = TextEditingController();

  /// Focus Node
  final _fnEmail = FocusNode();

  /// Key
  final _keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    _conEmail.dispose();
    _fnEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (_, state) => switch (state) {
        ForgotPasswordStateLoading() => context.show(),
        ForgotPasswordStateSuccess(:final data) => (() {
            context.dismiss();
            data?.meta?.message.toString().toToastSuccess(context);
            context.goNamed(Routes.login.name);
          })(),
        ForgotPasswordStateFailure(:final message) => (() {
            context.dismiss();
            message.toToastError(context);
          })(),
        _ => {},
      },
      child: Parent(
        appBar: CustomAppBar(
          title: Strings.of(context)!.forgotPassword,
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimens.size16),
          child: Form(
            key: _keyForm,
            child: ListView(
              children: [
                TextF(
                  autofillHints: const [AutofillHints.email],
                  key: const Key("email"),
                  curFocusNode: _fnEmail,
                  textInputAction: TextInputAction.done,
                  controller: _conEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  hintText: Strings.of(context)!.forgotPasswordDesc,
                  hint: Strings.of(context)!.email,
                  validator: (String? value) => value != null
                      ? (!value.isValidEmail()
                          ? Strings.of(context)?.errorInvalidEmail
                          : null)
                      : null,
                ),
                SpacerV(value: Dimens.space24),
                Button(
                  title: Strings.of(context)!.send,
                  onPressed: () {
                    if (_keyForm.currentState?.validate() ?? false) {
                      context.read<ForgotPasswordCubit>().forgotPassword(
                            ForgotPasswordParams(email: _conEmail.text),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
