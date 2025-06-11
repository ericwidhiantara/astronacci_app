import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class LogoWatermark extends StatelessWidget {
  const LogoWatermark({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.size10,
        ),
        padding: EdgeInsets.all(Dimens.size15),
        child: Image.asset(
          Images.icLogo,
          height: Dimens.size35,
        ),
      ),
    );
  }
}
