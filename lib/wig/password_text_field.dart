import 'package:flutter/material.dart';

import 'package:todoapp/wig/text_field_decoration.dart';

import '../util/colors.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController textController;
  final FormFieldValidator validator;
  final String fieldTitle;


  const PasswordTextFieldWidget({
    super.key,
    required this.hintText,
    required this.textController,
    required this.validator,
    required this.fieldTitle,

  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      PasswordTextFieldWidgetState();
}

class PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool _textVisible = true;
  bool isBoxBorder=true;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: widget.validator,
        controller: widget.textController,
        cursorColor: blackColor,
        obscureText: _textVisible,
        style: TextStyle(color: Colors.white),

        decoration: TextFieldDecoration.kPasswordFieldDecoration.copyWith(
          contentPadding: isBoxBorder ? EdgeInsets.all(20) :  EdgeInsets.only(left:20),
          enabledBorder: isBoxBorder?OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          )
              : const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: isBoxBorder
              ?  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          )
              : const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),

          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _textVisible = !_textVisible;
              });
            }, icon: Icon(Icons.remove_red_eye),
            // icon: _textVisible
                // ? SvgPicture.asset(Assets.passwordVisibilityOff)
                // : SvgPicture.asset(Assets.passwordVisibilityOn),
          ),
          hintText: widget.hintText,
        ));
  }
}
