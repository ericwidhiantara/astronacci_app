import 'package:flutter/material.dart';

class CameraLoadingIndicator extends StatelessWidget {
  const CameraLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
