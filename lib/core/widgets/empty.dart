import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Empty extends StatelessWidget {
  final double? height;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final TextStyle? textStyle;
  final Color? imageColor;
  final Color? buttonColor;
  final Color? buttonTitleColor;

  const Empty({
    super.key,
    this.errorMessage,
    this.height,
    this.onRetry,
    this.textStyle,
    this.imageColor,
    this.buttonColor,
    this.buttonTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SvgImages.icEmptyState,
          colorFilter: imageColor != null
              ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
              : null,
        ),
        SpacerV(
          value: Dimens.size20,
        ),
        Text(
          errorMessage ?? Strings.of(context)!.errorNoData,
          textAlign: TextAlign.center,
          style: textStyle ??
              Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: Dimens.text14,
                    fontWeight: FontWeight.w400,
                  ),
        ),
        SpacerV(
          value: Dimens.size20,
        ),
        if (onRetry != null)
          SizedBox(
            width: Dimens.size100 + Dimens.size40,
            child: Button(
              title: Strings.of(context)!.retry,
              color: buttonColor,
              titleColor: buttonTitleColor,
              onPressed: () {
                onRetry?.call();
              },
            ),
          ),
      ],
    );
  }
}
