import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomLogoutDialog extends StatelessWidget {
  const CustomLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Strings.of(context)!.logout),
      content: Text(Strings.of(context)!.logoutDesc),
      actions: [
        TextButton(
          onPressed: () {
            context.read<AuthCubit>().logout();
            Future.delayed(const Duration(seconds: 2), () {
              if (!context.mounted) return;

              context.goNamed(Routes.login.name);
            });
          },
          child: Text(Strings.of(context)!.yes),
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(Strings.of(context)!.cancel),
        ),
      ],
    );
  }
}
