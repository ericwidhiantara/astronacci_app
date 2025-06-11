import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarIcon extends StatelessWidget {
  final String iconPath;
  final bool isActive;

  const NavBarIcon({
    super.key,
    required this.iconPath,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Theme.of(context).extension<CustomColor>()!.primary!
        : Theme.of(context).dividerColor;

    return SvgPicture.asset(
      iconPath,
      height: Dimens.size22,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
