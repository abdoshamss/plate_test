import 'package:flutter/material.dart';

import '../../core/extensions/all_extensions.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? hintText, label, errorText;
  final TextInputType type;
  bool password = false;
  final bool expanded;
  final Color? borderColor, backgroundColor, filledColor, activeBorderColor;
  final Color hintColor;
  final bool floatingHint;
  final int? maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;

  // final void Function()? onTap;
  FocusNode? focusNode;
  TextAlign textalign;
  int? maxLengh;
  TextDirection? textdirection;
  EdgeInsetsGeometry? contentPadding;
  double borderRadius;
  double? hintSize;
  String? prefixIcon;
  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  Widget? suffixIcon, suffixWidget, prefixWidget;
  TextEditingController? controller;
  InputDecoration? inputDecoration;
  ValueChanged<String>? onChanged;
  ValueChanged<String?>? onSaved;
  String? Function(String?)? validator;
  bool? isOutline;
  bool? enable;
  bool? readOnly;

  TextFormFieldWidget({
    this.onChanged,
    this.onSaved,
    this.isOutline,
    this.readOnly,
    this.hintSize,
    this.enable = true,
    this.validator,
    this.onTap,
    this.prefixWidget,
    this.password = false,
    this.expanded = false,
    this.floatingHint = false,
    this.type = TextInputType.text,
    this.hintText,
    this.label,
    this.textalign = TextAlign.start,
    this.maxLengh,
    this.errorText,
    this.controller,
    this.activeBorderColor = const Color(0x058A8C95),
    this.borderRadius = 16,
    this.borderColor,
    this.backgroundColor,
    this.hintColor = const Color(0xffA1A7AD),
    this.maxLines,
    this.minLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.inputDecoration,
    this.contentPadding,
    this.textdirection,
    super.key,
    this.filledColor,
    this.prefixIconWidget,
    this.suffixIconWidget,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool passHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label.text(
            textTheme: context.titleLarge
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
        TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          cursorColor: context.colorScheme.primary,
          validator: widget.validator,
          maxLength: widget.maxLengh,
          focusNode: widget.focusNode,
          controller: widget.controller,
          maxLines: widget.maxLines ?? 1,
          minLines: widget.minLines,
          textAlign: widget.textalign,
          textDirection: widget.textdirection,
          style: context.bodySmall?.copyWith(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          decoration: widget.inputDecoration ??
              InputDecoration(
                isDense: true,
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 10),
                filled: true,
                fillColor: widget.filledColor ?? context.formFieldColor,
                prefixIcon: widget.prefixIconWidget ??
                    widget.prefixIcon?.toSvg(color: context.bodySmall?.color),
                prefix: widget.prefixWidget,
                suffix: widget.suffixWidget,
                suffixIcon: widget.suffixIconWidget ??
                    widget.suffixIcon ??
                    (widget.password
                        ? IconButton(
                            onPressed: () =>
                                setState(() => passHidden = !passHidden),
                            icon: Icon(
                              passHidden
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off,
                              color: widget.hintColor,
                            ),
                          )
                        : null),
                errorText: widget.errorText,
                // helperText: "",
                border: widget.enable ?? false ? borderType() : null,
                focusedBorder: borderType(),
                enabledBorder: borderType(),
                errorBorder: borderType(),

                hintStyle: TextStyle(
                    color: widget.hintColor,
                    fontSize: widget.hintSize ?? 16,
                    fontWeight: FontWeight.w400),
                hintText: widget.hintText,
              ),
          keyboardType: widget.type,
          obscureText: passHidden && widget.password,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          onTap: () => widget.onTap?.call(),
          readOnly: widget.onTap != null,
        ),
      ],
    );
  }

  InputBorder borderType() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: widget.activeBorderColor ?? Colors.transparent, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
    );
  }
}
