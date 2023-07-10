import 'package:flutter/material.dart';
import 'package:todoapp/util/tostmessade.dart';


import 'colors.dart';
import 'custom_snackbar.dart';

class AlternateAuthWidget extends StatelessWidget {
  final Widget screenName;
  final String text;
  final String widgetName;

  const AlternateAuthWidget({
    Key? key,
    required this.screenName,
    required this.text,
    required this.widgetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            snackBar(subTitle: 'This is a custom snack bar');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => screenName,
              ),
            );
          },
          child: Text(
            widgetName,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
