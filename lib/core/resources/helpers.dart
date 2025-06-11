import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  Helpers._();

  static Future<File> getImage({required String url}) async {
    /// Get Image from server
    final Response res = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    /// Get App local storage
    final Directory appDir = await getApplicationDocumentsDirectory();

    /// Generate Image Name
    final String imageName = url.split('/').last;

    /// Create Empty File in app dir & fill with new image
    final File file = File(join(appDir.path, imageName));

    file.writeAsBytesSync(res.data as List<int>);

    return file;
  }

  static FileDataType getFileType(String path) {
    final mimeType = lookupMimeType(path);

    if (mimeType != null) {
      if (mimeType.startsWith('image/')) {
        return FileDataType.image;
      } else if (mimeType.startsWith('audio/')) {
        return FileDataType.audio;
      } else if (mimeType.startsWith('video/')) {
        return FileDataType.video;
      } else if (mimeType.startsWith('application/pdf') ||
          mimeType.startsWith('application/msword') ||
          mimeType.startsWith('application/vnd.ms-excel') ||
          mimeType.startsWith('application/vnd.ms-powerpoint') ||
          mimeType.startsWith(
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          ) ||
          mimeType.startsWith(
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          ) ||
          mimeType.startsWith(
            'application/vnd.openxmlformats-officedocument.presentationml.presentation',
          ) ||
          mimeType.startsWith('text/plain')) {
        // Add more document types as needed
        return FileDataType.document;
      }
    }

    return FileDataType.unknown;
  }

  static String getFileSize(String path) {
    try {
      final File file = File(path);
      if (file.existsSync()) {
        final int fileSizeInBytes = file.lengthSync();
        return _formatFileSize(fileSizeInBytes);
      } else {
        return 'File not found';
      }
    } catch (e) {
      return 'Error getting file size';
    }
  }

  static String _formatFileSize(int bytes) {
    const int kb = 1024;
    const int mb = 1024 * kb;
    const int gb = 1024 * mb;

    if (bytes >= gb) {
      return '${(bytes / gb).toStringAsFixed(2)} GB';
    } else if (bytes >= mb) {
      return '${(bytes / mb).toStringAsFixed(2)} MB';
    } else if (bytes >= kb) {
      return '${(bytes / kb).toStringAsFixed(2)} KB';
    } else {
      return '$bytes bytes';
    }
  }

  static Future<File> convertImage(Uint8List image) async {
    final tempDir = await getTemporaryDirectory();
    final File file = await File(
      '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg',
    ).create();
    file.writeAsBytesSync(image);
    return file;
  }

  static String generateRandomFileName() {
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    final random = Random();
    final randomString =
        List.generate(10, (index) => letters[random.nextInt(letters.length)])
            .join();
    return 'document_$randomString.docx';
  }

  static String generateRandomString() {
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    final random = Random();
    final randomString =
        List.generate(10, (index) => letters[random.nextInt(letters.length)])
            .join();
    return randomString;
  }

  static String generateRandomIndonesianName() {
    const List<String> firstNames = [
      'Aditya',
      'Budi',
      'Citra',
      'Dewi',
      'Eka',
      'Farhan',
      'Gita',
      'Hadi',
      'Intan',
      'Joko',
    ];

    const List<String> lastNames = [
      'Wijaya',
      'Santoso',
      'Surya',
      'Pratama',
      'Hartono',
      'Putri',
      'Susilo',
      'Gunawan',
      'Kusuma',
      'Utama',
    ];

    final random = Random();
    final firstName = firstNames[random.nextInt(firstNames.length)];
    final lastName = lastNames[random.nextInt(lastNames.length)];

    return '$firstName $lastName';
  }

  static Future<void> launch(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static bool isServerVersionNewer(
    String serverVersion,
    String installedVersion,
  ) {
    List<int> parseVersion(String version) =>
        version.split('.').map((part) => int.tryParse(part) ?? 0).toList();

    final serverParts = parseVersion(serverVersion);
    final installedParts = parseVersion(installedVersion);

    for (int i = 0; i < serverParts.length || i < installedParts.length; i++) {
      final serverNumber = i < serverParts.length ? serverParts[i] : 0;
      final installedNumber = i < installedParts.length ? installedParts[i] : 0;

      if (serverNumber > installedNumber) return true;
      if (serverNumber < installedNumber) return false;
    }
    return false;
  }
}

enum FileDataType { document, audio, image, video, unknown }

enum PickerType { camera, gallery, document }
