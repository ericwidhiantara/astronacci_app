import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with MainBoxMixin {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppVersionCubit, AppVersionState>(
      listener: (_, state) => switch (state) {
        AppVersionStateSuccess(:final data) => (() {
            final String installedVersion =
                context.read<AppVersionCubit>().packageInfo!.version;
            final String? serverVersion = data?.data?.appVersion;

            // Check if server version exists and is greater than installed
            if (serverVersion != null &&
                Helpers.isServerVersionNewer(serverVersion, installedVersion)) {
              if (context.mounted) context.goNamed(Routes.appVersion.name);
              return; // Exit after handling version mismatch
            }

            // Proceed with normal flow
            final isLogin = getData<bool>(MainBoxKeys.isLogin) ?? false;
            final String route =
                isLogin ? Routes.register.name : Routes.login.name;
            if (context.mounted) context.goNamed(route);
          })(),
        AppVersionStateFailure() => (() {
            context.goNamed(Routes.login.name);
          })(),
        _ => {},
      },
      child: Parent(
        child: ColoredBox(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  Images.icLogo,
                  width: Dimens.size100,
                  height: Dimens.size100,
                ),
              ),
              SpacerV(value: Dimens.size30),
              SizedBox(
                width: Dimens.size100 + Dimens.size40,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
