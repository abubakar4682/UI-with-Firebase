import 'package:flutter/material.dart';
class TextFieldDecoration {
 static const Color textFieldEnabledColor = Colors.black12;
  static const kMessageContainerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    ),
  );

  static  InputDecoration kTextFieldDecoration = InputDecoration(

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.black)
  );
  static  InputDecoration kPasswordFieldDecoration = InputDecoration(


    hintText: 'Enter a value',
      hintStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),

  );
}
