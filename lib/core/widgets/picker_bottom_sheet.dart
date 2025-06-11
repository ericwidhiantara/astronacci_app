import 'dart:io';
import 'dart:typed_data';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:image_picker/image_picker.dart';

class PickerBottomSheet extends StatefulWidget {
  final Function(File file)? onFilePicked;
  final Object? extra;
  final VoidCallback? onTap;
  final bool isWithWatermark;

  const PickerBottomSheet({
    super.key,
    this.onFilePicked,
    this.onTap,
    this.extra,
    this.isWithWatermark = true,
  });

  @override
  State<PickerBottomSheet> createState() => _PickerBottomSheetState();
}

class _PickerBottomSheetState extends State<PickerBottomSheet> {
  List<PickerData> _pickerList = [];

  late File? _pickedFile;

  final picker = ImagePicker();

  Future<void> navigateToCamera(BuildContext context) async {
    final result = await context.pushNamed(
      Routes.camera.name,
      extra: widget.extra,
    );
    if (result != null && result is File) {
      _pickedFile = result;
      if (!context.mounted) return;
      final edited = await context.pushNamed(
        Routes.cameraPreview.name,
        extra: {
          "file": _pickedFile?.readAsBytesSync(),
          "isWithWatermark": widget.isWithWatermark,
        },
      );
      if (edited != null && edited is File) {
        widget.onFilePicked?.call(edited);
      }
    } else {
      if (context.mounted) {
        Strings.of(context)!.noFileSelected.toToastError(context);
      }
    }
  }

  Future<void> getImageGallery(BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        // Perform initial editing if needed (e.g., flip for front camera images)
        Uint8List? imageBytes = await imageFile.readAsBytes();

        final ImageEditorOption option = ImageEditorOption();
        // Example: Add flip or other options if needed
        // option.addOption(const FlipOption(horizontal: true));

        imageBytes = await ImageEditor.editImage(
          image: imageBytes,
          imageEditorOption: option,
        );

        // Save the edited image to the file
        await imageFile.writeAsBytes(imageBytes! as List<int>);

        if (!context.mounted) return;
        // Push to custom image editor for further editing
        final editedImage = await context.pushNamed(
          Routes.imageEditor.name,
          extra: imageBytes,
        );

        if (editedImage != null && editedImage is Uint8List) {
          // Save final edits to file
          // await imageFile.writeAsBytes(editedImage);
          if (!context.mounted) return;
          final edited = await context.pushNamed(
            Routes.cameraPreview.name,
            extra: {
              "file": editedImage,
              "isWithWatermark": widget.isWithWatermark,
            },
          );
          if (edited != null && edited is File) {
            // Callback with the final image file
            widget.onFilePicked?.call(edited);
          }
        }
      }
    } catch (error) {
      debugPrint('Error picking or editing image: $error');
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _pickerList = [
      PickerData(
        title: Strings.of(context)!.camera,
        icon: Icons.camera_alt_rounded,
        fileType: PickerType.camera,
      ),
      PickerData(
        title: Strings.of(context)!.gallery,
        icon: Icons.image,
        fileType: PickerType.gallery,
      ),
    ];
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.size15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Dimens.size100,
            child: Divider(
              thickness: Dimens.size3,
            ),
          ),
          Column(
            children: _pickerList.map((e) {
              return ListTile(
                onTap: () {
                  switch (e.fileType) {
                    case PickerType.camera:
                      navigateToCamera(context);

                    case PickerType.gallery:
                      getImageGallery(context);

                    default:
                      break;
                  }
                },
                leading: Icon(
                  e.icon,
                ),
                title: Text(
                  e.title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: Dimens.text12,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              );
            }).toList(),
          ),
          SpacerV(value: Dimens.size16),
        ],
      ),
    );
  }
}

class PickerData {
  final String title;
  final IconData icon;
  final Function(File file)? onFilePicked;
  final PickerType? fileType;

  PickerData({
    required this.title,
    required this.icon,
    this.onFilePicked,
    this.fileType,
  });
}
