import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class CameraPermissionDeniedWidget extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onRetryPermission;

  const CameraPermissionDeniedWidget({
    super.key,
    required this.onCancel,
    required this.onRetryPermission,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.of(context)!.cameraPermissionDenied,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: Dimens.text14,
                  color: Palette.white,
                ),
          ),
          SpacerV(value: Dimens.size16),
          Text(
            Strings.of(context)!.cameraPermissionDeniedDesc,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: Dimens.text12,
                  color: Palette.white,
                ),
          ),
          SpacerV(value: Dimens.size16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                width: MediaQuery.of(context).size.width * 0.4,
                color: Theme.of(context).extension<CustomColor>()!.text,
                onPressed: onCancel,
                title: Strings.of(context)!.cancel,
              ),
              Button(
                width: MediaQuery.of(context).size.width * 0.4,
                color: Theme.of(context).extension<CustomColor>()!.primary,
                onPressed: onRetryPermission,
                title: Strings.of(context)!.givePermission,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
