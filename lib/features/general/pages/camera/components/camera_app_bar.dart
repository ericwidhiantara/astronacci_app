import 'package:boilerplate/features/features.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraAppBar extends StatelessWidget {
  final FlashMode? flashMode;
  final VoidCallback onFlashPressed;

  const CameraAppBar({
    super.key,
    required this.flashMode,
    required this.onFlashPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(color: Colors.white),
              FlashToggleButton(
                flashMode: flashMode,
                onPressed: onFlashPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
