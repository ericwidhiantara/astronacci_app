import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// Controller
  final _conName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conPasswordRepeat = TextEditingController();

  /// Focus Node
  final _fnName = FocusNode();
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();
  final _fnPasswordRepeat = FocusNode();

  /// Global key form
  final _keyForm = GlobalKey<FormState>();

  Map<String, List<String>> _fieldErrors = {};

  @override
  void initState() {
    super.initState();

    _conName.addListener(() => _clearFieldError('name'));
    _conEmail.addListener(() => _clearFieldError('email'));
    _conPassword.addListener(() => _clearFieldError('password'));
    _conPasswordRepeat
        .addListener(() => _clearFieldError('password_confirmation'));
  }

  @override
  void dispose() {
    super.dispose();
    _conName.dispose();
    _conEmail.dispose();
    _conPassword.dispose();
    _conPasswordRepeat.dispose();
    _fnName.dispose();
    _fnEmail.dispose();
    _fnPassword.dispose();
    _fnPasswordRepeat.dispose();
  }

  void _clearFieldError(String key) {
    if (_fieldErrors.containsKey(key)) {
      setState(() {
        _fieldErrors.remove(key);
      });

      _keyForm.currentState?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: const CustomAppBar(
        title: 'Register',
      ),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (_, state) => switch (state) {
          RegisterStateLoading() => context.show(),
          RegisterStateSuccess(:final data) => (() {
              context.dismiss();
              data?.meta?.message.toString().toToastSuccess(context);

              context.goNamed(Routes.root.name);
            })(),
          RegisterStateFailure(:final errors, :final message) => (() {
              context.dismiss();
              setState(() {
                _fieldErrors =
                    Map<String, List<String>>.from(errors?.fields ?? {});
              });
              message.toToastError(context);
            })(),
          _ => {},
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: Form(
                key: _keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).hintColor,
                      radius: Dimens.profilePicture + Dimens.space4,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(Images.icLauncher),
                        radius: Dimens.profilePicture,
                      ),
                    ),
                    const SpacerV(),
                    TextF(
                      key: const Key("name"),
                      curFocusNode: _fnName,
                      nextFocusNode: _fnEmail,
                      textInputAction: TextInputAction.next,
                      controller: _conName,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      hintText: 'Enter your name',
                      hint: Strings.of(context)!.full_name,
                      textCapitalization: TextCapitalization.words,
                      validator: (String? value) {
                        if (_fieldErrors.containsKey('name')) {
                          return _fieldErrors['name']?.first;
                        }
                        if (value != null && value.isEmpty) {
                          return Strings.of(context)?.errorEmptyField;
                        }
                        return null;
                      },
                    ),
                    TextF(
                      key: const Key("email"),
                      curFocusNode: _fnEmail,
                      nextFocusNode: _fnPassword,
                      textInputAction: TextInputAction.next,
                      controller: _conEmail,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      hintText: 'johndoe@gmail.com',
                      hint: Strings.of(context)!.email,
                      validator: (String? value) {
                        if (_fieldErrors.containsKey('email')) {
                          return _fieldErrors['email']?.first;
                        }
                        if (value != null && !value.isValidEmail()) {
                          return Strings.of(context)?.errorInvalidEmail;
                        }
                        return null;
                      },
                    ),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (_, state) {
                        return Column(
                          children: [
                            TextF(
                              key: const Key("password"),
                              curFocusNode: _fnPassword,
                              nextFocusNode: _fnPasswordRepeat,
                              textInputAction: TextInputAction.next,
                              controller: _conPassword,
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              obscureText: context
                                      .read<RegisterCubit>()
                                      .isPasswordHide ??
                                  false,
                              hintText: '••••••••••••',
                              maxLine: 1,
                              hint: Strings.of(context)!.password,
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () => context
                                    .read<RegisterCubit>()
                                    .showHidePassword(),
                                icon: Icon(
                                  (context
                                              .read<RegisterCubit>()
                                              .isPasswordHide ??
                                          false)
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              validator: (String? value) {
                                if (_fieldErrors.containsKey('password')) {
                                  return _fieldErrors['password']?.first;
                                }
                                if (value != null && value.length < 6) {
                                  return Strings.of(context)
                                      ?.errorPasswordLength;
                                }
                                return null;
                              },
                              semantic: "password",
                            ),
                            TextF(
                              key: const Key("repeat_password"),
                              curFocusNode: _fnPasswordRepeat,
                              textInputAction: TextInputAction.done,
                              controller: _conPasswordRepeat,
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              obscureText: context
                                      .read<RegisterCubit>()
                                      .isPasswordRepeatHide ??
                                  false,
                              hintText: '••••••••••••',
                              maxLine: 1,
                              hint: Strings.of(context)!.passwordRepeat,
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () => context
                                    .read<RegisterCubit>()
                                    .showHidePasswordRepeat(),
                                icon: Icon(
                                  (context
                                              .read<RegisterCubit>()
                                              .isPasswordRepeatHide ??
                                          false)
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              validator: (String? value) {
                                if (_fieldErrors
                                    .containsKey('password_confirmation')) {
                                  return _fieldErrors['password_confirmation']
                                      ?.first;
                                }
                                if (value != null &&
                                    value != _conPassword.text) {
                                  return Strings.of(context)
                                      ?.errorPasswordNotMatch;
                                }
                                return null;
                              },
                              semantic: "repeat_password",
                            ),
                          ],
                        );
                      },
                    ),
                    SpacerV(value: Dimens.space24),
                    Button(
                      key: const Key("btn_register"),
                      title: Strings.of(context)!.register,
                      onPressed: () {
                        /// Validate form first
                        if (_keyForm.currentState?.validate() ?? false) {
                          context.read<RegisterCubit>().register(
                                RegisterParams(
                                  name: _conName.text,
                                  email: _conEmail.text,
                                  password: _conPassword.text,
                                  passwordConfirmation: _conPasswordRepeat.text,
                                ),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
