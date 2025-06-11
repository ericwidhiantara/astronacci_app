import 'package:flutter/material.dart';

class CameraShutterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CameraShutterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.circle, color: Colors.black54, size: 80),
          Icon(Icons.circle, color: Colors.white, size: 65),
        ],
      ),
    );
  }
}
