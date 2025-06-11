import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class FlipCameraButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isHidden;

  const FlipCameraButton({
    super.key,
    required this.onPressed,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            color: isHidden ? Colors.transparent : Colors.black38,
            size: Dimens.size60,
          ),
          Icon(
            Icons.flip_camera_ios,
            color: isHidden ? Colors.transparent : Colors.white,
            size: Dimens.size30,
          ),
        ],
      ),
    );
  }
}
