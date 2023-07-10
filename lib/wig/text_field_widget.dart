import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/wig/text_field_decoration.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final String? Function(dynamic) validator;
  final String? icon;
  final TextInputType? textInputType;
  final bool enabled;
  final bool readOnlyEnabled;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final Function(String)? onChanged;
  final TextAlign textAlign;
  final bool autoFocus;
  final bool isBoxBorder;
  final Widget? suffixIcon;
  final Function? suffixIconOnPressed;
  final bool expand;
  final int? maxLines;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.textController,
    required this.validator,
    this.icon,
    this.textInputType,
    this.enabled = true,
    this.maxLength = 100,
    this.readOnlyEnabled = false,
    this.onTap,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.autoFocus = false,
    required this.isBoxBorder,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.expand = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      enabled: enabled,
      keyboardType: textInputType ?? TextInputType.text,
      textAlign: textAlign,
      validator: validator,
      controller: textController,
      cursorColor: Colors.black,
      autofocus: autoFocus,
      expands: expand,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black, fontSize: 10),
      decoration: TextFieldDecoration.kTextFieldDecoration.copyWith(
        // first condition
          contentPadding:
              isBoxBorder ? const EdgeInsets.all(20) : const EdgeInsets.only(left: 20),
          // 2nd condition
          enabledBorder: isBoxBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
          focusedBorder: isBoxBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
          suffixIcon: suffixIcon != null && suffixIconOnPressed != null
              ? IconButton(
                  onPressed: () => suffixIconOnPressed!(),
                  icon: suffixIcon!,
                )
              : null,
          icon: icon != null
              ? Image.asset(
                  icon!,
                  color: Colors.black,
                )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 15)),
      onTap: onTap,
      onChanged: (value) => onChanged == null ? null : onChanged!(value),
      readOnly: readOnlyEnabled,
    );
  }
}
