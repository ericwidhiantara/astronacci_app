import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? titleColor;
  final Color? borderColor;
  final double? fontSize;
  final Color? splashColor;
  final double radius;
  final EdgeInsets? margin;
  final bool isUpperCase;
  final Widget? prefixIcon;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
    this.color,
    this.titleColor,
    this.borderColor,
    this.fontSize,
    this.splashColor,
    this.radius = Dimens.cornerRadius,
    this.margin,
    this.isUpperCase = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.symmetric(vertical: Dimens.space8),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              color ?? Theme.of(context).extension<CustomColor>()!.primary,
          foregroundColor:
              Theme.of(context).extension<CustomColor>()!.background,
          padding: EdgeInsets.symmetric(horizontal: Dimens.space24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: Dimens.size1)
                : BorderSide.none,
          ),
          minimumSize: Size(
            width ?? context.widthInPercent(100),
            height ?? Dimens.buttonH,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: EdgeInsets.only(right: Dimens.size8),
                child: prefixIcon,
              ),
            Text(
              isUpperCase ? title.toUpperCase() : title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: titleColor ??
                        Theme.of(context).extension<CustomColor>()!.background,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
