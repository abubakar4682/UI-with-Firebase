import 'package:flutter/material.dart';
import 'package:todoapp/view/update.dart';

import '../util/circular_loader.dart';
import '../util/colors.dart';
import '../util/custom_snackbar.dart';
import '../wig/text_field_widget.dart';
import 'package:firebase_database/firebase_database.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({Key? key}) : super(key: key);

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? textvalidate(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Enter Some text';
    }
    return null; // Return null if the validation succeeds
  }

  bool loading = false;
  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTextColor,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(
              textInputType: TextInputType.emailAddress,
              textController: textController,
              hintText: "Enter some text",
              validator: textvalidate,
              isBoxBorder: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await database
                          .child(DateTime.now().millisecond.toString())
                          .set({
                        "title": textController.text.toString(),
                        "id": DateTime.now().millisecond.toString(),
                      }).then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Update()),
                        );
                        setState(() {
                          loading = false;
                        });
                        final snackBarr =
                            snackBar(subTitle: 'Your Post has been added');
                        ScaffoldMessenger.of(context).showSnackBar(snackBarr);
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        final snackBarr = snackBar(subTitle: error.toString());
                        ScaffoldMessenger.of(context).showSnackBar(snackBarr);
                      });
                      //   if (_formKey.currentState!.validate()) {}
                    },
                    child: loading
                        ? const CircularLoaderWidget()
                        : const Text(
                            'Upload this text',
                            style: TextStyle(color: Colors.white),
                          ))),
          ],
        ),
      ),
    );
  }
}
