import 'dart:io';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_editor/image_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class CameraPageState extends State<CameraPage>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool isCameraInitialized = false;
  bool isCameraPermissionGranted = false;
  bool isRearCameraSelected = true;
  FlashMode? currentFlashMode;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    getPermissionStatus();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<void> getPermissionStatus() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      initializeCamera();
    } else {
      openAppSettings();
    }
  }

  void initializeCamera() {
    setState(() => isCameraPermissionGranted = true);
    onNewCameraSelected(widget.isSelfie! ? cameras[1] : cameras[0]);
  }

  Future<void> onNewCameraSelected(CameraDescription description) async {
    final newController = CameraController(
      description,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    await controller?.dispose();
    controller = newController;

    try {
      await newController.initialize();
      currentFlashMode = newController.value.flashMode;
      if (mounted) setState(() => isCameraInitialized = true);
    } on CameraException catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  void toggleCamera() {
    setState(() {
      isCameraInitialized = false;
      isRearCameraSelected = !isRearCameraSelected;
    });
    onNewCameraSelected(cameras[isRearCameraSelected ? 0 : 1]);
  }

  void cycleFlashMode() {
    final newFlashMode = currentFlashMode == FlashMode.off
        ? FlashMode.auto
        : currentFlashMode == FlashMode.auto
            ? FlashMode.always
            : FlashMode.off;

    controller?.setFlashMode(newFlashMode);
    setState(() => currentFlashMode = newFlashMode);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final x = details.localPosition.dx / constraints.maxWidth;
    final y = details.localPosition.dy / constraints.maxHeight;
    controller?.setExposurePoint(Offset(x, y));
    controller?.setFocusPoint(Offset(x, y));
  }

  Future<void> handleTakePicture() async {
    final imageFile = await processImage();
    if (!mounted || imageFile == null) return;

    final result = await context.pushNamed(
      Routes.imageEditor.name,
      extra: imageFile.readAsBytesSync(),
    );

    if (result is Uint8List) {
      await imageFile.writeAsBytes(result);
      if (mounted) context.back(imageFile);
    }
  }

  Future<File?> processImage() async {
    final rawImage = await controller?.takePicture();
    if (rawImage == null) return null;

    File imageFile = File(rawImage.path);
    if (widget.isSelfie! || !isRearCameraSelected) {
      imageFile = await flipFrontCameraImage(imageFile);
    }

    return await saveImageToStorage(imageFile);
  }

  Future<File> flipFrontCameraImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final flippedBytes = await ImageEditor.editImage(
      image: bytes,
      imageEditorOption: ImageEditorOption()..addOption(const FlipOption()),
    );

    await imageFile.delete();
    return await imageFile.writeAsBytes(flippedBytes!);
  }

  Future<File> saveImageToStorage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final newPath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    return await imageFile.copy(newPath);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
