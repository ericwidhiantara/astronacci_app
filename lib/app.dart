import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/dependencies_injection.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    log.d(const String.fromEnvironment('ENV'));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SettingsCubit>()..getActiveTheme()),
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<LogoutCubit>()),
        BlocProvider(create: (_) => sl<AppVersionCubit>()..fetchAppVersion()),
      ],
      child: OKToast(
        child: ScreenUtilInit(
          /// Set screen size to make responsive
          /// Almost all device

          designSize: const Size(375, 667),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) {
            /// Pass context to appRoute
            AppRoute.setStream(context);

            return BlocBuilder<SettingsCubit, DataHelper>(
              builder: (_, data) {
                log.i("Active Theme: ${data.activeTheme.mode}");
                log.i("Active Locale: ${data.type}");
                return MaterialApp.router(
                  routerConfig: AppRoute.router,
                  localizationsDelegates: const [
                    Strings.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  builder: (BuildContext context, Widget? child) {
                    final MediaQueryData data = MediaQuery.of(context);

                    return MediaQuery(
                      data: data.copyWith(
                        alwaysUse24HourFormat: true,
                      ),
                      child: child!,
                    );
                  },
                  title: Constants.get.appName,
                  theme: themeLight(context),
                  darkTheme: themeDark(context),
                  locale: Locale(data.type ?? "en"),
                  supportedLocales: L10n.all,
                  themeMode: data.activeTheme.mode,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
