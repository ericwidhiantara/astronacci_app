import 'dart:typed_data';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';

class WatermarkPreview extends StatelessWidget {
  final Uint8List file;
  final LocationModel location;
  final bool isWithWatermark;

  const WatermarkPreview({
    super.key,
    required this.file,
    required this.location,
    this.isWithWatermark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.memory(
          file,
          fit: BoxFit.cover,
        ),
        if (isWithWatermark) LocationWatermark(location: location),
        if (isWithWatermark) const LogoWatermark(),
      ],
    );
  }
}
