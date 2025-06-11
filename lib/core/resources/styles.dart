import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeLight(BuildContext context) => ThemeData(
      fontFamily: 'Poppins',
      useMaterial3: true,
      primaryColor: Palette.primary,
      disabledColor: Palette.grey400,
      hintColor: Palette.textSecondary,
      cardColor: Palette.card,
      scaffoldBackgroundColor: Palette.background,
      dividerColor: Palette.grey200,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Palette.primary,
        surface: Palette.background,
      ),
      datePickerTheme: DatePickerThemeData(
        headerForegroundColor: Palette.primary,
        backgroundColor: Palette.background,
        dayBackgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return Palette.primary;
            }
            return Palette.white;
          },
        ),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => IconButton(
          onPressed: () => Navigator.maybePop(context),
          padding: const EdgeInsets.only(left: 8.0),
          icon: Container(
            width: Dimens.size28,
            height: Dimens.size28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.grey200,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 12.0,
                color: Palette.grey800,
              ),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 57.0,
              color: Palette.text,
            ),
        displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 45.0,
              color: Palette.text,
            ),
        displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 36.0,
              color: Palette.text,
            ),
        headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 32.0,
              color: Palette.text,
            ),
        headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 28.0,
              color: Palette.text,
            ),
        titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 22.0,
              color: Palette.text,
            ),
        titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 16.0,
              color: Palette.text,
            ),
        titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 14.0,
              color: Palette.text,
            ),
        bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16.0,
              color: Palette.text,
            ),
        bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.0,
              color: Palette.text,
            ),
        bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12.0,
              color: Palette.text,
            ),
        labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 14.0,
              color: Palette.text,
            ),
        labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 11.0,
              letterSpacing: 0.25,
              color: Palette.text,
            ),
      ),
      appBarTheme: const AppBarTheme().copyWith(
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        color: Palette.background,
        iconTheme: const IconThemeData(color: Palette.primary),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        surfaceTintColor: Palette.background,
        shadowColor: Palette.grey800,
      ),
      drawerTheme: const DrawerThemeData().copyWith(
        elevation: 0.0,
        surfaceTintColor: Palette.background,
        backgroundColor: Palette.background,
      ),
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: Palette.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
      ),
      dialogTheme: const DialogTheme().copyWith(
        backgroundColor: Palette.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
      ),
      brightness: Brightness.light,
      iconTheme: const IconThemeData(color: Palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: const <ThemeExtension<dynamic>>[
        CustomColor(
          primary: Palette.primary,
          primary50: Palette.primary50,
          primary100: Palette.primary100,
          primary200: Palette.primary200,
          primary300: Palette.primary300,
          primary400: Palette.primary400,
          primary500: Palette.primary500,
          primary600: Palette.primary600,
          primary700: Palette.primary700,
          primary800: Palette.primary800,
          primary900: Palette.primary900,
          primary950: Palette.primary950,
          secondary: Palette.secondary,
          secondary50: Palette.secondary50,
          secondary100: Palette.secondary100,
          secondary200: Palette.secondary200,
          secondary300: Palette.secondary300,
          secondary400: Palette.secondary400,
          secondary500: Palette.secondary500,
          secondary600: Palette.secondary600,
          secondary700: Palette.secondary700,
          secondary800: Palette.secondary800,
          secondary900: Palette.secondary900,
          secondary950: Palette.secondary950,
          grey50: Palette.grey50,
          grey100: Palette.grey100,
          grey200: Palette.grey200,
          grey300: Palette.grey300,
          grey400: Palette.grey400,
          grey500: Palette.grey500,
          grey600: Palette.grey600,
          grey700: Palette.grey700,
          grey800: Palette.grey800,
          grey900: Palette.grey900,
          grey950: Palette.grey950,
          red50: Palette.red50,
          red100: Palette.red100,
          red200: Palette.red200,
          red300: Palette.red300,
          red400: Palette.red400,
          red500: Palette.red500,
          red600: Palette.red600,
          red700: Palette.red700,
          red800: Palette.red800,
          red900: Palette.red900,
          red950: Palette.red950,
          yellow50: Palette.yellow50,
          yellow100: Palette.yellow100,
          yellow200: Palette.yellow200,
          yellow300: Palette.yellow300,
          yellow400: Palette.yellow400,
          yellow500: Palette.yellow500,
          yellow600: Palette.yellow600,
          yellow700: Palette.yellow700,
          yellow800: Palette.yellow800,
          yellow900: Palette.yellow900,
          yellow950: Palette.yellow950,
          green50: Palette.green50,
          green100: Palette.green100,
          green200: Palette.green200,
          green300: Palette.green300,
          green400: Palette.green400,
          green500: Palette.green500,
          green600: Palette.green600,
          green700: Palette.green700,
          green800: Palette.green800,
          green900: Palette.green900,
          green950: Palette.green950,
          info50: Palette.info50,
          info100: Palette.info100,
          info200: Palette.info200,
          info300: Palette.info300,
          info400: Palette.info400,
          info500: Palette.info500,
          info600: Palette.info600,
          info700: Palette.info700,
          info800: Palette.info800,
          info900: Palette.info900,
          info950: Palette.info950,
          background: Palette.background,
          backgroundDark: Palette.backgroundDark,
          black: Palette.black,
          white: Palette.white,
          card: Palette.card,
          cardDark: Palette.cardDark,
          text: Palette.text,
          textDark: Palette.textDark,
          textSecondary: Palette.textSecondary,
          textSecondaryDark: Palette.textSecondaryDark,
        ),
      ],
    );

ThemeData themeDark(BuildContext context) => ThemeData(
      fontFamily: 'Poppins',
      useMaterial3: true,
      primaryColor: Palette.primary,
      disabledColor: Palette.grey400,
      hintColor: Palette.textSecondaryDark,
      cardColor: Palette.cardDark,
      scaffoldBackgroundColor: Palette.backgroundDark,
      dividerColor: Palette.grey600,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Palette.primary,
        surface: Palette.backgroundDark,
      ),
      datePickerTheme: DatePickerThemeData(
        headerForegroundColor: Palette.primary,
        backgroundColor: Palette.backgroundDark,
        dayBackgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return Palette.primary;
            }
            return Palette.cardDark;
          },
        ),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => IconButton(
          onPressed: () => Navigator.maybePop(context),
          padding: const EdgeInsets.only(left: 8.0),
          icon: Container(
            width: Dimens.size28,
            height: Dimens.size28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.grey800,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 12.0,
                color: Palette.white,
              ),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 57.0,
              color: Palette.textDark,
            ),
        displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 45.0,
              color: Palette.textDark,
            ),
        displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 36.0,
              color: Palette.textDark,
            ),
        headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 32.0,
              color: Palette.textDark,
            ),
        headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 28.0,
              color: Palette.textDark,
            ),
        titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 22.0,
              color: Palette.textDark,
            ),
        titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 16.0,
              color: Palette.textDark,
            ),
        titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 14.0,
              color: Palette.textDark,
            ),
        bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16.0,
              color: Palette.textDark,
            ),
        bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.0,
              color: Palette.textDark,
            ),
        bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12.0,
              color: Palette.textDark,
            ),
        labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 14.0,
              color: Palette.textDark,
            ),
        labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 11.0,
              letterSpacing: 0.25,
              color: Palette.textDark,
            ),
      ),
      appBarTheme: const AppBarTheme().copyWith(
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        color: Palette.backgroundDark,
        iconTheme: const IconThemeData(color: Palette.primary),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        surfaceTintColor: Palette.backgroundDark,
        shadowColor: Palette.grey800,
      ),
      drawerTheme: const DrawerThemeData().copyWith(
        elevation: 0.0,
        surfaceTintColor: Palette.backgroundDark,
        backgroundColor: Palette.backgroundDark,
      ),
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: Palette.backgroundDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
      ),
      dialogTheme: const DialogTheme().copyWith(
        backgroundColor: Palette.backgroundDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
      ),
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(color: Palette.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: const <ThemeExtension<dynamic>>[
        CustomColor(
          primary: Palette.primary,
          primary50: Palette.primary50,
          primary100: Palette.primary100,
          primary200: Palette.primary200,
          primary300: Palette.primary300,
          primary400: Palette.primary400,
          primary500: Palette.primary500,
          primary600: Palette.primary600,
          primary700: Palette.primary700,
          primary800: Palette.primary800,
          primary900: Palette.primary900,
          primary950: Palette.primary950,
          secondary: Palette.secondary,
          secondary50: Palette.secondary50,
          secondary100: Palette.secondary100,
          secondary200: Palette.secondary200,
          secondary300: Palette.secondary300,
          secondary400: Palette.secondary400,
          secondary500: Palette.secondary500,
          secondary600: Palette.secondary600,
          secondary700: Palette.secondary700,
          secondary800: Palette.secondary800,
          secondary900: Palette.secondary900,
          secondary950: Palette.secondary950,
          grey50: Palette.grey50,
          grey100: Palette.grey100,
          grey200: Palette.grey200,
          grey300: Palette.grey300,
          grey400: Palette.grey400,
          grey500: Palette.grey500,
          grey600: Palette.grey600,
          grey700: Palette.grey700,
          grey800: Palette.grey800,
          grey900: Palette.grey900,
          grey950: Palette.grey950,
          red50: Palette.red50,
          red100: Palette.red100,
          red200: Palette.red200,
          red300: Palette.red300,
          red400: Palette.red400,
          red500: Palette.red500,
          red600: Palette.red600,
          red700: Palette.red700,
          red800: Palette.red800,
          red900: Palette.red900,
          red950: Palette.red950,
          yellow50: Palette.yellow50,
          yellow100: Palette.yellow100,
          yellow200: Palette.yellow200,
          yellow300: Palette.yellow300,
          yellow400: Palette.yellow400,
          yellow500: Palette.yellow500,
          yellow600: Palette.yellow600,
          yellow700: Palette.yellow700,
          yellow800: Palette.yellow800,
          yellow900: Palette.yellow900,
          yellow950: Palette.yellow950,
          green50: Palette.green50,
          green100: Palette.green100,
          green200: Palette.green200,
          green300: Palette.green300,
          green400: Palette.green400,
          green500: Palette.green500,
          green600: Palette.green600,
          green700: Palette.green700,
          green800: Palette.green800,
          green900: Palette.green900,
          green950: Palette.green950,
          info50: Palette.info50,
          info100: Palette.info100,
          info200: Palette.info200,
          info300: Palette.info300,
          info400: Palette.info400,
          info500: Palette.info500,
          info600: Palette.info600,
          info700: Palette.info700,
          info800: Palette.info800,
          info900: Palette.info900,
          info950: Palette.info950,
          background: Palette.backgroundDark,
          backgroundDark: Palette.backgroundDark,
          black: Palette.black,
          white: Palette.white,
          card: Palette.cardDark,
          cardDark: Palette.cardDark,
          text: Palette.textDark,
          textDark: Palette.textDark,
          textSecondary: Palette.textSecondaryDark,
          textSecondaryDark: Palette.textSecondaryDark,
        ),
      ],
    );

class CustomColor extends ThemeExtension<CustomColor> {
  // Primary Colors (Blue)
  final Color? primary;
  final Color? primary50;
  final Color? primary100;
  final Color? primary200;
  final Color? primary300;
  final Color? primary400;
  final Color? primary500;
  final Color? primary600;
  final Color? primary700;
  final Color? primary800;
  final Color? primary900;
  final Color? primary950;

  // Secondary Colors (Orange)
  final Color? secondary;
  final Color? secondary50;
  final Color? secondary100;
  final Color? secondary200;
  final Color? secondary300;
  final Color? secondary400;
  final Color? secondary500;
  final Color? secondary600;
  final Color? secondary700;
  final Color? secondary800;
  final Color? secondary900;
  final Color? secondary950;

  // Grey Colors
  final Color? grey50;
  final Color? grey100;
  final Color? grey200;
  final Color? grey300;
  final Color? grey400;
  final Color? grey500;
  final Color? grey600;
  final Color? grey700;
  final Color? grey800;
  final Color? grey900;
  final Color? grey950;

  // Red Colors
  final Color? red50;
  final Color? red100;
  final Color? red200;
  final Color? red300;
  final Color? red400;
  final Color? red500;
  final Color? red600;
  final Color? red700;
  final Color? red800;
  final Color? red900;
  final Color? red950;

  // Yellow Colors
  final Color? yellow50;
  final Color? yellow100;
  final Color? yellow200;
  final Color? yellow300;
  final Color? yellow400;
  final Color? yellow500;
  final Color? yellow600;
  final Color? yellow700;
  final Color? yellow800;
  final Color? yellow900;
  final Color? yellow950;

  // Green Colors
  final Color? green50;
  final Color? green100;
  final Color? green200;
  final Color? green300;
  final Color? green400;
  final Color? green500;
  final Color? green600;
  final Color? green700;
  final Color? green800;
  final Color? green900;
  final Color? green950;

  // Info Colors
  final Color? info50;
  final Color? info100;
  final Color? info200;
  final Color? info300;
  final Color? info400;
  final Color? info500;
  final Color? info600;
  final Color? info700;
  final Color? info800;
  final Color? info900;
  final Color? info950;

  // Additional Colors
  final Color? background;
  final Color? backgroundDark;
  final Color? black;
  final Color? white;
  final Color? card;
  final Color? cardDark;
  final Color? text;
  final Color? textDark;
  final Color? textSecondary;
  final Color? textSecondaryDark;

  const CustomColor({
    this.primary,
    this.primary50,
    this.primary100,
    this.primary200,
    this.primary300,
    this.primary400,
    this.primary500,
    this.primary600,
    this.primary700,
    this.primary800,
    this.primary900,
    this.primary950,
    this.secondary,
    this.secondary50,
    this.secondary100,
    this.secondary200,
    this.secondary300,
    this.secondary400,
    this.secondary500,
    this.secondary600,
    this.secondary700,
    this.secondary800,
    this.secondary900,
    this.secondary950,
    this.grey50,
    this.grey100,
    this.grey200,
    this.grey300,
    this.grey400,
    this.grey500,
    this.grey600,
    this.grey700,
    this.grey800,
    this.grey900,
    this.grey950,
    this.red50,
    this.red100,
    this.red200,
    this.red300,
    this.red400,
    this.red500,
    this.red600,
    this.red700,
    this.red800,
    this.red900,
    this.red950,
    this.yellow50,
    this.yellow100,
    this.yellow200,
    this.yellow300,
    this.yellow400,
    this.yellow500,
    this.yellow600,
    this.yellow700,
    this.yellow800,
    this.yellow900,
    this.yellow950,
    this.green50,
    this.green100,
    this.green200,
    this.green300,
    this.green400,
    this.green500,
    this.green600,
    this.green700,
    this.green800,
    this.green900,
    this.green950,
    this.info50,
    this.info100,
    this.info200,
    this.info300,
    this.info400,
    this.info500,
    this.info600,
    this.info700,
    this.info800,
    this.info900,
    this.info950,
    this.background,
    this.backgroundDark,
    this.black,
    this.white,
    this.card,
    this.cardDark,
    this.text,
    this.textDark,
    this.textSecondary,
    this.textSecondaryDark,
  });

  @override
  ThemeExtension<CustomColor> copyWith({
    Color? primary,
    Color? primary50,
    Color? primary100,
    Color? primary200,
    Color? primary300,
    Color? primary400,
    Color? primary500,
    Color? primary600,
    Color? primary700,
    Color? primary800,
    Color? primary900,
    Color? primary950,
    Color? secondary,
    Color? secondary50,
    Color? secondary100,
    Color? secondary200,
    Color? secondary300,
    Color? secondary400,
    Color? secondary500,
    Color? secondary600,
    Color? secondary700,
    Color? secondary800,
    Color? secondary900,
    Color? secondary950,
    Color? grey50,
    Color? grey100,
    Color? grey200,
    Color? grey300,
    Color? grey400,
    Color? grey500,
    Color? grey600,
    Color? grey700,
    Color? grey800,
    Color? grey900,
    Color? grey950,
    Color? red50,
    Color? red100,
    Color? red200,
    Color? red300,
    Color? red400,
    Color? red500,
    Color? red600,
    Color? red700,
    Color? red800,
    Color? red900,
    Color? red950,
    Color? yellow50,
    Color? yellow100,
    Color? yellow200,
    Color? yellow300,
    Color? yellow400,
    Color? yellow500,
    Color? yellow600,
    Color? yellow700,
    Color? yellow800,
    Color? yellow900,
    Color? yellow950,
    Color? green50,
    Color? green100,
    Color? green200,
    Color? green300,
    Color? green400,
    Color? green500,
    Color? green600,
    Color? green700,
    Color? green800,
    Color? green900,
    Color? green950,
    Color? info50,
    Color? info100,
    Color? info200,
    Color? info300,
    Color? info400,
    Color? info500,
    Color? info600,
    Color? info700,
    Color? info800,
    Color? info900,
    Color? info950,
    Color? background,
    Color? backgroundDark,
    Color? black,
    Color? white,
    Color? card,
    Color? cardDark,
    Color? text,
    Color? textDark,
    Color? textSecondary,
    Color? textSecondaryDark,
  }) {
    return CustomColor(
      primary: primary ?? this.primary,
      primary50: primary50 ?? this.primary50,
      primary100: primary100 ?? this.primary100,
      primary200: primary200 ?? this.primary200,
      primary300: primary300 ?? this.primary300,
      primary400: primary400 ?? this.primary400,
      primary500: primary500 ?? this.primary500,
      primary600: primary600 ?? this.primary600,
      primary700: primary700 ?? this.primary700,
      primary800: primary800 ?? this.primary800,
      primary900: primary900 ?? this.primary900,
      primary950: primary950 ?? this.primary950,
      secondary: secondary ?? this.secondary,
      secondary50: secondary50 ?? this.secondary50,
      secondary100: secondary100 ?? this.secondary100,
      secondary200: secondary200 ?? this.secondary200,
      secondary300: secondary300 ?? this.secondary300,
      secondary400: secondary400 ?? this.secondary400,
      secondary500: secondary500 ?? this.secondary500,
      secondary600: secondary600 ?? this.secondary600,
      secondary700: secondary700 ?? this.secondary700,
      secondary800: secondary800 ?? this.secondary800,
      secondary900: secondary900 ?? this.secondary900,
      secondary950: secondary950 ?? this.secondary950,
      grey50: grey50 ?? this.grey50,
      grey100: grey100 ?? this.grey100,
      grey200: grey200 ?? this.grey200,
      grey300: grey300 ?? this.grey300,
      grey400: grey400 ?? this.grey400,
      grey500: grey500 ?? this.grey500,
      grey600: grey600 ?? this.grey600,
      grey700: grey700 ?? this.grey700,
      grey800: grey800 ?? this.grey800,
      grey900: grey900 ?? this.grey900,
      grey950: grey950 ?? this.grey950,
      red50: red50 ?? this.red50,
      red100: red100 ?? this.red100,
      red200: red200 ?? this.red200,
      red300: red300 ?? this.red300,
      red400: red400 ?? this.red400,
      red500: red500 ?? this.red500,
      red600: red600 ?? this.red600,
      red700: red700 ?? this.red700,
      red800: red800 ?? this.red800,
      red900: red900 ?? this.red900,
      red950: red950 ?? this.red950,
      yellow50: yellow50 ?? this.yellow50,
      yellow100: yellow100 ?? this.yellow100,
      yellow200: yellow200 ?? this.yellow200,
      yellow300: yellow300 ?? this.yellow300,
      yellow400: yellow400 ?? this.yellow400,
      yellow500: yellow500 ?? this.yellow500,
      yellow600: yellow600 ?? this.yellow600,
      yellow700: yellow700 ?? this.yellow700,
      yellow800: yellow800 ?? this.yellow800,
      yellow900: yellow900 ?? this.yellow900,
      yellow950: yellow950 ?? this.yellow950,
      green50: green50 ?? this.green50,
      green100: green100 ?? this.green100,
      green200: green200 ?? this.green200,
      green300: green300 ?? this.green300,
      green400: green400 ?? this.green400,
      green500: green500 ?? this.green500,
      green600: green600 ?? this.green600,
      green700: green700 ?? this.green700,
      green800: green800 ?? this.green800,
      green900: green900 ?? this.green900,
      green950: green950 ?? this.green950,
      info50: info50 ?? this.info50,
      info100: info100 ?? this.info100,
      info200: info200 ?? this.info200,
      info300: info300 ?? this.info300,
      info400: info400 ?? this.info400,
      info500: info500 ?? this.info500,
      info600: info600 ?? this.info600,
      info700: info700 ?? this.info700,
      info800: info800 ?? this.info800,
      info900: info900 ?? this.info900,
      info950: info950 ?? this.info950,
      background: background ?? this.background,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      black: black ?? this.black,
      white: white ?? this.white,
      card: card ?? this.card,
      cardDark: cardDark ?? this.cardDark,
      text: text ?? this.text,
      textDark: textDark ?? this.textDark,
      textSecondary: textSecondary ?? this.textSecondary,
      textSecondaryDark: textSecondaryDark ?? this.textSecondaryDark,
    );
  }

  @override
  ThemeExtension<CustomColor> lerp(
    covariant ThemeExtension<CustomColor>? other,
    double t,
  ) {
    if (other is! CustomColor) {
      return this;
    }
    return CustomColor(
      primary: Color.lerp(primary, other.primary, t),
      primary50: Color.lerp(primary50, other.primary50, t),
      primary100: Color.lerp(primary100, other.primary100, t),
      primary200: Color.lerp(primary200, other.primary200, t),
      primary300: Color.lerp(primary300, other.primary300, t),
      primary400: Color.lerp(primary400, other.primary400, t),
      primary500: Color.lerp(primary500, other.primary500, t),
      primary600: Color.lerp(primary600, other.primary600, t),
      primary700: Color.lerp(primary700, other.primary700, t),
      primary800: Color.lerp(primary800, other.primary800, t),
      primary900: Color.lerp(primary900, other.primary900, t),
      primary950: Color.lerp(primary950, other.primary950, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      secondary50: Color.lerp(secondary50, other.secondary50, t),
      secondary100: Color.lerp(secondary100, other.secondary100, t),
      secondary200: Color.lerp(secondary200, other.secondary200, t),
      secondary300: Color.lerp(secondary300, other.secondary300, t),
      secondary400: Color.lerp(secondary400, other.secondary400, t),
      secondary500: Color.lerp(secondary500, other.secondary500, t),
      secondary600: Color.lerp(secondary600, other.secondary600, t),
      secondary700: Color.lerp(secondary700, other.secondary700, t),
      secondary800: Color.lerp(secondary800, other.secondary800, t),
      secondary900: Color.lerp(secondary900, other.secondary900, t),
      secondary950: Color.lerp(secondary950, other.secondary950, t),
      grey50: Color.lerp(grey50, other.grey50, t),
      grey100: Color.lerp(grey100, other.grey100, t),
      grey200: Color.lerp(grey200, other.grey200, t),
      grey300: Color.lerp(grey300, other.grey300, t),
      grey400: Color.lerp(grey400, other.grey400, t),
      grey500: Color.lerp(grey500, other.grey500, t),
      grey600: Color.lerp(grey600, other.grey600, t),
      grey700: Color.lerp(grey700, other.grey700, t),
      grey800: Color.lerp(grey800, other.grey800, t),
      grey900: Color.lerp(grey900, other.grey900, t),
      grey950: Color.lerp(grey950, other.grey950, t),
      red50: Color.lerp(red50, other.red50, t),
      red100: Color.lerp(red100, other.red100, t),
      red200: Color.lerp(red200, other.red200, t),
      red300: Color.lerp(red300, other.red300, t),
      red400: Color.lerp(red400, other.red400, t),
      red500: Color.lerp(red500, other.red500, t),
      red600: Color.lerp(red600, other.red600, t),
      red700: Color.lerp(red700, other.red700, t),
      red800: Color.lerp(red800, other.red800, t),
      red900: Color.lerp(red900, other.red900, t),
      red950: Color.lerp(red950, other.red950, t),
      yellow50: Color.lerp(yellow50, other.yellow50, t),
      yellow100: Color.lerp(yellow100, other.yellow100, t),
      yellow200: Color.lerp(yellow200, other.yellow200, t),
      yellow300: Color.lerp(yellow300, other.yellow300, t),
      yellow400: Color.lerp(yellow400, other.yellow400, t),
      yellow500: Color.lerp(yellow500, other.yellow500, t),
      yellow600: Color.lerp(yellow600, other.yellow600, t),
      yellow700: Color.lerp(yellow700, other.yellow700, t),
      yellow800: Color.lerp(yellow800, other.yellow800, t),
      yellow900: Color.lerp(yellow900, other.yellow900, t),
      yellow950: Color.lerp(yellow950, other.yellow950, t),
      green50: Color.lerp(green50, other.green50, t),
      green100: Color.lerp(green100, other.green100, t),
      green200: Color.lerp(green200, other.green200, t),
      green300: Color.lerp(green300, other.green300, t),
      green400: Color.lerp(green400, other.green400, t),
      green500: Color.lerp(green500, other.green500, t),
      green600: Color.lerp(green600, other.green600, t),
      green700: Color.lerp(green700, other.green700, t),
      green800: Color.lerp(green800, other.green800, t),
      green900: Color.lerp(green900, other.green900, t),
      green950: Color.lerp(green950, other.green950, t),
      info50: Color.lerp(info50, other.info50, t),
      info100: Color.lerp(info100, other.info100, t),
      info200: Color.lerp(info200, other.info200, t),
      info300: Color.lerp(info300, other.info300, t),
      info400: Color.lerp(info400, other.info400, t),
      info500: Color.lerp(info500, other.info500, t),
      info600: Color.lerp(info600, other.info600, t),
      info700: Color.lerp(info700, other.info700, t),
      info800: Color.lerp(info800, other.info800, t),
      info900: Color.lerp(info900, other.info900, t),
      info950: Color.lerp(info950, other.info950, t),
      background: Color.lerp(background, other.background, t),
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t),
      black: Color.lerp(black, other.black, t),
      white: Color.lerp(white, other.white, t),
      card: Color.lerp(card, other.card, t),
      cardDark: Color.lerp(cardDark, other.cardDark, t),
      text: Color.lerp(text, other.text, t),
      textDark: Color.lerp(textDark, other.textDark, t),
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t),
      textSecondaryDark:
          Color.lerp(textSecondaryDark, other.textSecondaryDark, t),
    );
  }
}

class BoxDecorations {
  BoxDecorations(this.context);

  final BuildContext context;

  BoxDecoration get button => BoxDecoration(
        color: Palette.primary,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [BoxShadows(context).button],
      );

  BoxDecoration get card => BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [BoxShadows(context).card],
      );
}

class BoxShadows {
  BoxShadows(this.context);

  final BuildContext context;

  BoxShadow get button => BoxShadow(
        color: Theme.of(context)
            .extension<CustomColor>()!
            .grey800!
            .withValues(alpha: 0.5),
        blurRadius: 16.0,
        spreadRadius: 1.0,
      );

  BoxShadow get card => BoxShadow(
        color: Theme.of(context)
            .extension<CustomColor>()!
            .grey800!
            .withValues(alpha: 0.5),
        blurRadius: 5.0,
        spreadRadius: 0.5,
      );

  BoxShadow get dialog => BoxShadow(
        color: Theme.of(context).extension<CustomColor>()!.grey800!,
        offset: const Offset(0, -4),
        blurRadius: 16.0,
      );

  BoxShadow get dialogAlt => BoxShadow(
        color: Theme.of(context).extension<CustomColor>()!.grey800!,
        offset: const Offset(0, 4),
        blurRadius: 16.0,
      );

  BoxShadow get buttonMenu => BoxShadow(
        color: Theme.of(context).extension<CustomColor>()!.grey800!,
        blurRadius: 4.0,
      );
}
