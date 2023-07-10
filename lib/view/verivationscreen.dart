import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todoapp/view/post.dart';

import '../util/circular_loader.dart';
import '../util/colors.dart';
import '../wig/text_field_widget.dart';

class Verificationscreen extends StatefulWidget {
  final String verificationid;
  const Verificationscreen({required this.verificationid, Key? key});

  @override
  State<Verificationscreen> createState() => _VerificationscreenState();
}

class _VerificationscreenState extends State<Verificationscreen> {
  final sixdigitcode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  void dispose() {
    sixdigitcode.dispose();
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
              //  const Text('6 digit number',style: TextStyle(color: Colors.cyanAccent),),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldWidget(
                  textInputType: TextInputType.emailAddress,
                  textController: sixdigitcode,
                  hintText: "Enter 6 digit bunvber",
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
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        final credital = PhoneAuthProvider.credential(
                            verificationId: widget.verificationid,
                            smsCode: sixdigitcode.text.toString());
                        try {
                          await auth.signInWithCredential(credital);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  Post()));
                        } catch (e) {
                          setState(() {
                            loading = false;
                          });
                          Get.snackbar(e.toString(), '');
                        }
                      },
                      child: loading
                          ? const CircularLoaderWidget()
                          : const Text(
                              'Verify',
                              style: TextStyle(color: Colors.white),
                            ))),
            ],
          ),
        ),
      ),
    );
  }
}
