import 'dart:typed_data';

import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  final String? imagePath;
  final bool isFromNetwork;
  final Uint8List? imageBytes;

  const PhotoViewer({
    super.key,
    this.imagePath,
    this.isFromNetwork = false,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PhotoView(
                imageProvider: isFromNetwork
                    ? NetworkImage(
                        imagePath!,
                      )
                    : MemoryImage(imageBytes!) as ImageProvider,
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
