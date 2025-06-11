import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final bool? isSelfie;
  final bool? isEnableFlipCamera;

  const CameraPage({
    super.key,
    this.isSelfie = false,
    this.isEnableFlipCamera = false,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends CameraPageState {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: isCameraPermissionGranted
            ? isCameraInitialized
                ? CameraInterface(
                    controller: controller!,
                    isRearCameraSelected: isRearCameraSelected,
                    currentFlashMode: currentFlashMode,
                    isEnableFlipCamera: widget.isEnableFlipCamera,
                    mediaSize: MediaQuery.of(context).size,
                    onViewFinderTap: onViewFinderTap,
                    onFlipCamera: () => toggleCamera(),
                    onFlashPressed: cycleFlashMode,
                    onTakePicture: handleTakePicture,
                  )
                : const CameraLoadingIndicator()
            : CameraPermissionDeniedWidget(
                onCancel: context.back,
                onRetryPermission: getPermissionStatus,
              ),
      ),
    );
  }
}
