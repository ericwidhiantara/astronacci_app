import 'package:boilerplate/features/features.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraInterface extends StatelessWidget {
  final CameraController controller;
  final bool isRearCameraSelected;
  final FlashMode? currentFlashMode;
  final bool? isEnableFlipCamera;
  final Size mediaSize;
  final Function(TapDownDetails, BoxConstraints) onViewFinderTap;
  final VoidCallback onFlipCamera;
  final VoidCallback onFlashPressed;
  final VoidCallback onTakePicture;

  const CameraInterface({
    super.key,
    required this.controller,
    required this.isRearCameraSelected,
    required this.currentFlashMode,
    required this.isEnableFlipCamera,
    required this.mediaSize,
    required this.onViewFinderTap,
    required this.onFlipCamera,
    required this.onFlashPressed,
    required this.onTakePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreviewWidget(
          controller: controller,
          mediaSize: mediaSize,
          onViewFinderTap: onViewFinderTap,
        ),
        CameraAppBar(
          flashMode: currentFlashMode,
          onFlashPressed: onFlashPressed,
        ),
        CameraControls(
          isEnableFlipCamera: isEnableFlipCamera,
          onFlipCamera: onFlipCamera,
          onTakePicture: onTakePicture,
        ),
      ],
    );
  }
}
