import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraController controller;
  final Size mediaSize;
  final Function(TapDownDetails, BoxConstraints) onViewFinderTap;

  const CameraPreviewWidget({
    super.key,
    required this.controller,
    required this.mediaSize,
    required this.onViewFinderTap,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1 / (controller.value.aspectRatio * mediaSize.aspectRatio),
      alignment: Alignment.topCenter,
      child: CameraPreview(
        controller,
        child: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) => onViewFinderTap(details, constraints),
          ),
        ),
      ),
    );
  }
}
