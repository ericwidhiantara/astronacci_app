import 'dart:typed_data';
import 'dart:ui';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;

class ImageEditorWidget extends StatefulWidget {
  final Uint8List imageBytes;

  const ImageEditorWidget({super.key, required this.imageBytes});

  @override
  _ImageEditorWidgetState createState() => _ImageEditorWidgetState();
}

class _ImageEditorWidgetState extends State<ImageEditorWidget> {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();

  late ImageProvider provider;

  @override
  void initState() {
    super.initState();
    provider = ExtendedMemoryImageProvider(
      widget.imageBytes,
      cacheRawData: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: _appBar(context),
      bottomNavigation: _buildFunctions(),
      child: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: buildImage(),
            ),
          ],
        ),
      ),
    );
  }

  final ImageEditorController _editorController = ImageEditorController();

  Widget buildImage() {
    return ExtendedImage(
      image: provider,
      extendedImageEditorKey: editorKey,
      mode: ExtendedImageMode.editor,
      fit: BoxFit.contain,
      initEditorConfigHandler: (_) => EditorConfig(
        maxScale: 8.0,
        controller: _editorController,
      ),
    );
  }

  Widget _buildFunctions() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.flip),
          label: 'Putar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rotate_left),
          label: 'Putar ke Kiri',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rotate_right),
          label: 'Putar ke Kanan',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            flip();
          case 1:
            rotate(false);
          case 2:
            rotate(true);
        }
      },
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
    );
  }

  Future<void> crop(ImageEditorController imageEditorController) async {
    final EditActionDetails action = imageEditorController.editActionDetails!;

    final Uint8List img = imageEditorController.state!.rawImageData;

    final ImageEditorOption option = ImageEditorOption();

    if (action.hasRotateDegrees) {
      final int rotateDegrees = action.rotateDegrees.toInt();
      option.addOption(RotateOption(rotateDegrees));
    }
    if (action.flipY) {
      option.addOption(const FlipOption());
    }

    if (action.needCrop) {
      Rect cropRect = imageEditorController.getCropRect()!;
      if (imageEditorController.state!.widget.extendedImageState.imageProvider
          is ExtendedResizeImage) {
        final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(img);
        final ImageDescriptor descriptor =
            await ImageDescriptor.encoded(buffer);

        final double widthRatio =
            descriptor.width / imageEditorController.state!.image!.width;
        final double heightRatio =
            descriptor.height / imageEditorController.state!.image!.height;
        cropRect = Rect.fromLTRB(
          cropRect.left * widthRatio,
          cropRect.top * heightRatio,
          cropRect.right * widthRatio,
          cropRect.bottom * heightRatio,
        );
      }
      option.addOption(ClipOption.fromRect(cropRect));
    }

    final Uint8List? result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

    if (result != null && mounted) {
      context.back(result);
    }
  }

  void flip() {
    editorKey.currentState?.flip();
  }

  void rotate(bool right) {
    editorKey.currentState?.rotate(
      degree: right ? 90 : -90,
    );
  }

  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: () async {
              await crop(_editorController);
            },
          ),
        ],
      ),
    );
  }
}
