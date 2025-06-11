import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';

class CameraPreviewControls extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onConfirm;

  const CameraPreviewControls({
    super.key,
    required this.onRetry,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: Dimens.size20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            icon: Icons.refresh,
            onPressed: onRetry,
          ),
          CircleButton(
            icon: Icons.check,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
