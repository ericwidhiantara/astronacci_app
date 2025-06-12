import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.label,
    this.description,
    this.activeColor,
    this.materialTapTargetSize,
    this.hintText,
    this.subtitle,
    this.isHintVisible = true,
    this.isSubtitleVisible = true,
    this.required = false,
  });

  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget? label;
  final Widget? description;
  final Color? activeColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool isHintVisible;
  final bool isSubtitleVisible;
  final String? hintText;
  final String? subtitle;
  final bool? required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isHintVisible,
          child: Row(
            children: [
              Text(
                hintText ?? "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).extension<CustomColor>()!.text,
                      fontSize: Dimens.text14,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              if (required == true)
                Text(
                  " *",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: Dimens.text14,
                        fontWeight: FontWeight.w400,
                      ),
                ),
            ],
          ),
        ),
        Visibility(
          visible: isSubtitleVisible,
          child: Text(
            subtitle ?? "",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).extension<CustomColor>()!.text,
                  fontSize: Dimens.text12,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        MergeSemantics(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                focusNode: focusNode,
                autofocus: autofocus,
                activeColor: activeColor,
                materialTapTargetSize: materialTapTargetSize,
              ),
              if (label != null) label!,
            ],
          ),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: description,
          ),
      ],
    );
  }
}
