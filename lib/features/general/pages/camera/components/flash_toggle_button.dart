import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashToggleButton extends StatelessWidget {
  final FlashMode? flashMode;
  final VoidCallback onPressed;

  const FlashToggleButton({
    super.key,
    required this.flashMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.circle, color: Colors.black38, size: 60),
          Icon(_getFlashIcon(), color: _getFlashColor()),
        ],
      ),
    );
  }

  IconData _getFlashIcon() {
    switch (flashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      default:
        return Icons.flash_off;
    }
  }

  Color _getFlashColor() {
    return flashMode == FlashMode.off ? Colors.white : Colors.amber;
  }
}
