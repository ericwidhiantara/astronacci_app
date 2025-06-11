import 'dart:async';

import 'package:boilerplate/app.dart';
import 'package:boilerplate/dependencies_injection.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<CameraDescription> cameras = [];

void main() {
  runZonedGuarded(
    /// Lock device orientation to portrait
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await FirebaseServices.init();

      /// Register Service locator
      await serviceLocator();
      try {
        cameras = await availableCameras();
      } on CameraException catch (e) {
        debugPrint('Error in fetching the cameras: $e');
      }
      return SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      ).then((_) => runApp(App()));
    },
    (error, stackTrace) {
      debugPrint('runZonedGuarded: Caught error: $error');
      debugPrint('runZonedGuarded: Caught stacktrace: $stackTrace');
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
