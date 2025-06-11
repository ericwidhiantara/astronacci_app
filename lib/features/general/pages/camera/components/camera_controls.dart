import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';

class CameraControls extends StatelessWidget {
  final bool? isEnableFlipCamera;
  final VoidCallback onFlipCamera;
  final VoidCallback onTakePicture;

  const CameraControls({
    super.key,
    required this.isEnableFlipCamera,
    required this.onFlipCamera,
    required this.onTakePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlipCameraButton(
                onPressed: onFlipCamera,
                isHidden: true,
              ),
              CameraShutterButton(onPressed: onTakePicture),
              // const Spacer(),
              if (isEnableFlipCamera!)
                FlipCameraButton(onPressed: onFlipCamera),
            ],
          ),
        ),
      ),
    );
  }
}
