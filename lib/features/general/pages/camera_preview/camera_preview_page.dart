import 'dart:io';
import 'dart:typed_data';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';

class CameraPreviewPage extends StatefulWidget {
  final Uint8List image;
  final bool isWithWatermark;

  const CameraPreviewPage({
    super.key,
    required this.image,
    this.isWithWatermark = false,
  });

  @override
  State<CameraPreviewPage> createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  late LocationModel location;
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getLocation());
  }

  Future<void> getLocation() async {
    final Position position = await LocationApi().determineLocation(context);
    location = await LocationApi()
        .getAddressByCoordinates(position.latitude, position.longitude);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      backgroundColor: Colors.black,
      bottomNavigation: isLoading
          ? null
          : CameraPreviewControls(
              onRetry: () => context.pop(),
              onConfirm: () async {
                await screenshotController
                    .captureFromWidget(
                  WatermarkPreview(
                    file: widget.image,
                    location: location,
                    isWithWatermark: widget.isWithWatermark,
                  ),
                  context: context,
                )
                    .then((Uint8List? image) async {
                  final File imageFile = await Helpers.convertImage(image!);
                  if (!context.mounted) return;
                  context.pop(imageFile);
                });
              },
            ),
      child: isLoading
          ? Center(
              child: Loading(
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Palette.white,
                    ),
              ),
            )
          : Screenshot(
              controller: screenshotController,
              child: Stack(
                children: [
                  Center(
                    child: WatermarkPreview(
                      file: widget.image,
                      location: location,
                      isWithWatermark: widget.isWithWatermark,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 24.0,
                      ),
                      onPressed: () {
                        context.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
