import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todoapp/spleshescreen/Spleshescreen.dart';
import 'package:todoapp/util/alternate_auth_widget.dart';
import 'package:todoapp/util/circular_loader.dart';
import 'package:todoapp/util/colors.dart';
import 'package:todoapp/util/size_config.dart';
import 'package:todoapp/util/utils.dart';
import 'package:todoapp/view/post.dart';
import 'package:todoapp/view/sign_up_screen.dart';
import 'package:todoapp/wig/custom_button_widget.dart';
import 'package:todoapp/wig/password_text_field.dart';
import 'package:todoapp/wig/text_field_widget.dart';

import '../util/custom_snackbar.dart';
import '../util/tostmessade.dart';
import 'login_with_number.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSignInLoading = false;
  final _auth = FirebaseAuth.instance;
  late bool loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  String? _validateEmail(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null; // Return null if the validation succeeds
  }

  String? _validatePassword(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null; // Return null if the validation succeeds
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      _auth
          .signInWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passController.text.toString())
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Post()),
        );
        setState(() {
          loading = false;
        });
        Get.snackbar(
          value.user!.email.toString(),
          'hello',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        //Message().Tositmessage(value.user!.email.toString());
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Get.snackbar(
          error.toString(),
          '',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        // Message().Tositmessage(error.toString());
      });
      // Perform login logic here
      // You can access the entered email and password using _emailController.text and _passController.text
      print('Email: ${_emailController.text}');
      print('Password: ${_passController.text}');

      // Navigate to the next screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => NextScreen(),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTextColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      ' Email',
                      style: TextStyle(color: lightSeaGreenColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      //  textInputType: TextInputType.emailAddress,
                      textController: _emailController,
                      hintText: "johndoe@gmail.com",

                      validator: _validateEmail, isBoxBorder: true,
                    ),
                    const SizedBox(height: 40.0),
                    const Text(' Password',
                        style: TextStyle(color: lightSeaGreenColor)),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordTextFieldWidget(
                      textController: _passController,
                      hintText: "Enter your password",
                      fieldTitle: "Password",
                      validator: _validatePassword,
                    ),
                    const _ForgotPasswordWidget(),
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () => _login(context),
                            child: loading
                                ? const CircularLoaderWidget()
                                : const Text(
                                    'login',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                    Padding(
                        padding: EdgeInsets.only(
                          top: (SizeConfig.height15(context) * 2) + 4,
                          bottom: (SizeConfig.height8(context) * 3),
                        ),
                        child: const AlternateAuthWidget(
                          text: "Don't have an account?",
                          widgetName: "Signup",
                          screenName: Signupscreen(),
                        )),
                    InkWell(
                      onTap: () {
                        final SnackBar snackBarr =
                            snackBar(subTitle: 'This is a custom snack bar');
                        ScaffoldMessenger.of(context).showSnackBar(snackBarr);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginwithnumber(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white)),
                        child: const Center(
                            child: Text(
                          'Login with Number',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordWidget extends StatelessWidget {
  const _ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle forgot password logic here
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
