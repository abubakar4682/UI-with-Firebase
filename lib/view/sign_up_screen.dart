import 'package:flutter/material.dart';
import 'package:todoapp/spleshescreen/Spleshescreen.dart';
import 'package:todoapp/util/alternate_auth_widget.dart';
import 'package:todoapp/util/circular_loader.dart';
import 'package:todoapp/util/colors.dart';
import 'package:todoapp/util/size_config.dart';
import 'package:todoapp/util/utils.dart';
import 'package:todoapp/wig/custom_button_widget.dart';
import 'package:todoapp/wig/password_text_field.dart';
import 'package:todoapp/wig/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../util/custom_snackbar.dart';
import '../util/tostmessade.dart';
import 'login.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late  bool loading=false;
 // bool _isSignInLoading = false;
  FirebaseAuth _auth=FirebaseAuth.instance;
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
          // here i create a firebase instanse
 //
  void _signup(BuildContext context) {

  //   if (_formKey.currentState!.validate()) {
  // _auth.createUserWithEmailAndPassword(email: _emailController.text.toString(), password: _passController.text.toString()).then((value) {}).onError((error, stackTrace) {
  //   Message().Tositmessage(error.toString());
  //
  // });
  //
  //     // Perform login logic here
  //     // You can access the entered email and password using _emailController.text and _passController.text
  //     print('Email: ${_emailController.text}');
  //     print('Password: ${_passController.text}');
  //
  //
  //     // Navigate to the next screen
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => NextScreen(),
  //     //   ),
  //     // );
  //   }
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
                   // snackBar(subTitle: 'hello'),

                    Text(' Email',style: TextStyle(color:lightSeaGreenColor ),),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      textInputType: TextInputType.emailAddress,
                      textController: _emailController,
                      hintText: "johndoe@gmail.com",
                      validator: _validateEmail, isBoxBorder: true,
                    ),
                    const SizedBox(height: 40.0),
                    Text(' Password',style: TextStyle(color:lightSeaGreenColor )),
                    SizedBox(
                      height: 10,
                    ),
                    PasswordTextFieldWidget(

                      textController: _passController,
                      hintText: "Enter your password",
                      fieldTitle: "Password",
                      validator: _validatePassword,
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextButton(onPressed: (){

                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading=true;
                            });
                            _auth.createUserWithEmailAndPassword(email: _emailController.text.toString(), password: _passController.text.toString()).then((value) {
                              setState(() {

                                loading=false;
                              });
                            }).onError((error, stackTrace) {
                              setState(() {

                                loading=false;
                              });
                              Message().Tositmessage(error.toString());

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

                        },


                            child:loading ? CircularLoaderWidget() :

                            Text('Sign up',style: TextStyle(color: Colors.white),))),
                    Padding(
                        padding: EdgeInsets.only(
                          top: (SizeConfig.height15(context) * 2) + 4,
                          bottom: (SizeConfig.height8(context) * 3),
                        ),
                        child:  AlternateAuthWidget(
                          text: "Already have account?",
                          widgetName: "Login", screenName:LoginScreen() ,
                        )
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


