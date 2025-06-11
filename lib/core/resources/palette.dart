import 'package:flutter/material.dart';

class Palette {
  Palette._();

  // Primary Colors (Blue)
  static const Color primary = Color(0xff0844DF);
  static const Color primary50 = Color(0xffEDF6FF);
  static const Color primary100 = Color(0xffD7EAFF);
  static const Color primary200 = Color(0xffB8DBFF);
  static const Color primary300 = Color(0xff87C6FF);
  static const Color primary400 = Color(0xff4FA6FF);
  static const Color primary500 = Color(0xff288FFF);
  static const Color primary600 = Color(0xff0F5FFF);
  static const Color primary700 = Color(0xff0844DF);
  static const Color primary800 = Color(0xff0E3BBF);
  static const Color primary900 = Color(0xff123696);
  static const Color primary950 = Color(0xff10225B);

  // Secondary Colors (Orange)
  static const Color secondary = Color(0xffFF6E0A);
  static const Color secondary50 = Color(0xffFFF7ED);
  static const Color secondary100 = Color(0xffFFEDD4);
  static const Color secondary200 = Color(0xffFFD7A8);
  static const Color secondary300 = Color(0xffFFBA70);
  static const Color secondary400 = Color(0xffFF9137);
  static const Color secondary500 = Color(0xffFF6E0A);
  static const Color secondary600 = Color(0xffF05606);
  static const Color secondary700 = Color(0xffC73F07);
  static const Color secondary800 = Color(0xff9E320E);
  static const Color secondary900 = Color(0xff7F2C0F);
  static const Color secondary950 = Color(0xff451305);

  // Grey Colors
  static const Color grey50 = Color(0xffFFF8F8);
  static const Color grey100 = Color(0xffEDEEF1);
  static const Color grey200 = Color(0xffD8DBDF);
  static const Color grey300 = Color(0xffB6BAC3);
  static const Color grey400 = Color(0xff8E95A2);
  static const Color grey500 = Color(0xff6B7280);
  static const Color grey600 = Color(0xff5B616E);
  static const Color grey700 = Color(0xff4A4E5A);
  static const Color grey800 = Color(0xff40444C);
  static const Color grey900 = Color(0xff383A42);
  static const Color grey950 = Color(0xff25272C);

  // Red Colors
  static const Color red50 = Color(0xffFFF0F0);
  static const Color red100 = Color(0xffFFDEDE);
  static const Color red200 = Color(0xffFFE3C3);
  static const Color red300 = Color(0xffFF9A9A);
  static const Color red400 = Color(0xffFF5F5F);
  static const Color red500 = Color(0xffFF2E2E);
  static const Color red600 = Color(0xffF41010);
  static const Color red700 = Color(0xffCE0707);
  static const Color red800 = Color(0xffAA0A0A);
  static const Color red900 = Color(0xff8C1010);
  static const Color red950 = Color(0xff440202);

  // Yellow Colors
  static const Color yellow50 = Color(0xffFFF8E8);
  static const Color yellow100 = Color(0xffFCFFC2);
  static const Color yellow200 = Color(0xffFEFF89);
  static const Color yellow300 = Color(0xffFFF833);
  static const Color yellow400 = Color(0xffFDEB12);
  static const Color yellow500 = Color(0xffECD106);
  static const Color yellow600 = Color(0xffCCA402);
  static const Color yellow700 = Color(0xffA37605);
  static const Color yellow800 = Color(0xff865C0D);
  static const Color yellow900 = Color(0xff724B11);
  static const Color yellow950 = Color(0xff432805);

  // Green Colors
  static const Color green50 = Color(0xffECFFE4);
  static const Color green100 = Color(0xffD5FFC5);
  static const Color green200 = Color(0xffACFF92);
  static const Color green300 = Color(0xff78FF53);
  static const Color green400 = Color(0xff48FB20);
  static const Color green500 = Color(0xff29F500);
  static const Color green600 = Color(0xff19B500);
  static const Color green700 = Color(0xff148902);
  static const Color green800 = Color(0xff146C08);
  static const Color green900 = Color(0xff145B0C);
  static const Color green950 = Color(0xff043300);

  // Info Colors
  static const Color info50 = Color(0xffEDF8FF);
  static const Color info100 = Color(0xffDEEFFF);
  static const Color info200 = Color(0xffB5E4FF);
  static const Color info300 = Color(0xff83D5FF);
  static const Color info400 = Color(0xff48BCFF);
  static const Color info500 = Color(0xffFE9AFF);
  static const Color info600 = Color(0xff067AFF);
  static const Color info700 = Color(0xff005CE6);
  static const Color info800 = Color(0xff084EC5);
  static const Color info900 = Color(0xff04469B);
  static const Color info950 = Color(0xff0E2B5D);

  static const Color background = Color(0xffF7F8F8);
  static const Color backgroundDark = Color(0xff1e1e2e);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color card = Color(0xffF9FAFD);
  static const Color cardDark = Color(0xff313244);
  static const Color text = Color(0xff1E293B);
  static const Color textDark = Color(0xffcdd6f4);
  static const Color textSecondary = Color(0xff475569);
  static const Color textSecondaryDark = Color(0xff6c7086);

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
