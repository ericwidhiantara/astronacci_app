import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomLogoutDialog extends StatelessWidget {
  const CustomLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (_, state) => switch (state) {
        LogoutStateLoading() => context.show(),
        LogoutStateSuccess(:final data) => (() {
            context.dismiss();
            data?.meta?.message.toString().toToastSuccess(context);
            context.read<AuthCubit>().logout();
            Future.delayed(const Duration(seconds: 2), () {
              if (!context.mounted) return;
              context.goNamed(Routes.login.name);
            });
          })(),
        LogoutStateFailure(:final type, :final message) => (() {
            context.dismiss();
            if (type is UnauthorizedFailure) {
              Strings.of(context)!.expiredToken.toToastError(context);
              context.goNamed(Routes.login.name);
            } else {
              message.toToastError(context);
            }
          })(),
        _ => {},
      },
      child: AlertDialog(
        title: Text(Strings.of(context)!.logout),
        content: Text(Strings.of(context)!.logoutDesc),
        actions: [
          TextButton(
            onPressed: () {
              context.read<LogoutCubit>().logout();
            },
            child: Text(Strings.of(context)!.yes),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(Strings.of(context)!.cancel),
          ),
        ],
      ),
    );
  }
}
