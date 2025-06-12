import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class CustomRadioList extends StatefulWidget {
  const CustomRadioList({
    super.key,
    required this.options,
    this.onChanged,
    this.hintText,
    this.subtitle,
    this.isHintVisible = true,
    this.isSubtitleVisible = true,
    this.required = false,
    this.activeColor,
    this.materialTapTargetSize,
  });

  final List<RadioOption> options;
  final ValueChanged<String?>? onChanged;
  final String? hintText;
  final String? subtitle;
  final bool isHintVisible;
  final bool isSubtitleVisible;
  final bool required;
  final Color? activeColor;
  final MaterialTapTargetSize? materialTapTargetSize;

  @override
  _CustomRadioListState createState() => _CustomRadioListState();
}

class _CustomRadioListState extends State<CustomRadioList> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize with no selection or first true value if required
    if (widget.required && widget.options.isNotEmpty) {
      _selectedValue = widget.options
          .firstWhere(
            (option) => option.value == "",
            orElse: () => widget.options.first,
          )
          .value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.isHintVisible,
          child: Row(
            children: [
              Text(
                widget.hintText ?? "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).extension<CustomColor>()!.text,
                      fontSize: Dimens.text14,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              if (widget.required)
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
          visible: widget.isSubtitleVisible,
          child: Text(
            widget.subtitle ?? "",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).extension<CustomColor>()!.text,
                  fontSize: Dimens.text12,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        ...widget.options.asMap().entries.map((entry) {
          final option = entry.value;
          return CustomRadio<String>(
            value: option.value,
            groupValue: _selectedValue ?? "",
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
              widget.onChanged?.call(value);
            },
            focusNode: option.focusNode,
            autofocus: option.autofocus,
            label: option.label,
            description: option.description,
            activeColor: widget.activeColor,
            materialTapTargetSize: widget.materialTapTargetSize,
            isHintVisible: false,
            isSubtitleVisible: false,
          );
        }),
        SpacerV(value: Dimens.size10),
      ],
    );
  }
}

class RadioOption {
  final String value;
  final Widget? label;
  final Widget? description;
  final FocusNode? focusNode;
  final bool autofocus;

  RadioOption({
    required this.value,
    this.label,
    this.description,
    this.focusNode,
    this.autofocus = false,
  });
}
