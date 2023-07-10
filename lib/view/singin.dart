import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../util/circular_loader.dart';
import '../util/colors.dart';
import '../util/utils.dart';
import '../wig/auth_banner_widget.dart';
import '../wig/custom_button_widget.dart';
import '../wig/password_text_field.dart';
import '../wig/text_field_widget.dart';
class Sinngin extends StatefulWidget {
  const Sinngin({Key? key}) : super(key: key);

  @override
  State<Sinngin> createState() => _SinnginState();
}

class _SinnginState extends State<Sinngin> {
  final _emailController = TextEditingController();

  String? _validateEmail(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null; // Return null if the validation succeeds
  }
  bool _isSignUpLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _userNameController = TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthBannerWidget(
                title: 'Sign up',
                description:
                'Welcome! to get started end the following details below',
              ),
              TextFieldWidget(
                textInputType: TextInputType.name,
                textController: _userNameController,
                hintText: "John Doe",

                validator: (value) => Utils.userNameValidator(value), isBoxBorder: true,
              ),
              TextFieldWidget(
                textInputType: TextInputType.emailAddress,
                textController: _emailController,
                hintText: "johndoe@gmail.com",
                validator: _validateEmail, isBoxBorder: true,
              ),
              PasswordTextFieldWidget(
                textController: _passController,
                hintText: "Enter password",
                fieldTitle: "Password",
                validator: (value) => Utils.passwordValidator(value),
              ),
              _isSignUpLoading
                  ? const CircularLoaderWidget()
                  : CustomButton(
                text: "CREATE",
                textColor: whiteColor,
                color: primaryColor,
                onTap: (){},
                // onTap: () async => signUp(
                //   _emailController.text,
                //   _passController.text,
                //   _userNameController.text,
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
