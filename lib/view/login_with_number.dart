import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/view/post.dart';
import 'package:todoapp/view/verivationscreen.dart';

import '../util/circular_loader.dart';
import '../util/colors.dart';
import '../util/custom_snackbar.dart';
import '../wig/auth_banner_widget.dart';
import '../wig/text_field_widget.dart';

class Loginwithnumber extends StatefulWidget {
  const Loginwithnumber({Key? key}) : super(key: key);

  @override
  State<Loginwithnumber> createState() => _LoginwithnumberState();
}

class _LoginwithnumberState extends State<Loginwithnumber> {
  final _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  void _login(BuildContext context) {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      auth.verifyPhoneNumber(
          phoneNumber: _numberController.text.toString(),
          verificationCompleted: (_) {
            setState(() {
              loading = false;
            });
          },
          verificationFailed: (e) {
            setState(() {
              loading = false;
            });
            Get.snackbar(e.toString(), 'error');
          },
          codeSent: (String verificationid, int? Token) {
            setState(() {
              loading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Verificationscreen(
                          verificationid: verificationid,
                        )));
          },
          codeAutoRetrievalTimeout: (e) {
            setState(() {
              loading = false;
            });
            final snackBarr = snackBar(subTitle: e);
            ScaffoldMessenger.of(context).showSnackBar(snackBarr);
            //   Get.snackbar(e, '');
          });
      print('Number: ${_numberController.text}');
    }
  }

  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  String? _validatenumber(dynamic value) {
    if (value == null)
      return 'Enter correct numberrrr';
    else
      return null; // Return null if the validation succeeds
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTextColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthBannerWidget(
                title: 'Sign up',
                description:
                    'Welcome! to get started end the following details below',
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldWidget(
                  textInputType: TextInputType.emailAddress,
                  textController: _numberController,
                  hintText: "+92 12345678",
                  isBoxBorder: true,
                  validator: _validatenumber,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () => _login(context),
                      child: loading
                          ? const CircularLoaderWidget()
                          : Text(
                              'login',
                              style: TextStyle(color: Colors.white),
                            ))),
            ],
          ),
        ),
      ),
    );
  }
}
