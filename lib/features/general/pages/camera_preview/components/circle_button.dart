import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(360),
      ),
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
            size: Dimens.size80,
          ),
          Icon(
            icon,
            color: Palette.white,
            size: Dimens.size55,
          ),
        ],
      ),
    );
  }
}
