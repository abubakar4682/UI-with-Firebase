import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/circular_loader.dart';
import '../util/colors.dart';
import '../util/custom_snackbar.dart';
import '../view/update.dart';
import '../wig/text_field_widget.dart';

class Firestorescreen extends StatefulWidget {
  const Firestorescreen({Key? key}) : super(key: key);

  @override
  State<Firestorescreen> createState() => _FirestorescreenState();
}

class _FirestorescreenState extends State<Firestorescreen> {
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? textvalidate(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Enter Some text';
    }
    return null; // Return null if the validation succeeds
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool loading = false;

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'full_name': textController.text, // John Doe
    })
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Update()),
      );
      setState(() {
        loading = false;
      });
      final snackBarr = snackBar(subTitle: 'Your Post has been added');
      ScaffoldMessenger.of(context).showSnackBar(snackBarr);
    })
        .catchError((error) {
      setState(() {
        loading = false;
      });
      final snackBarr = snackBar(subTitle: error.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackBarr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  if (_formKey.currentState!.validate()) {
                    await addUser();
                  }
                },
                child: loading
                    ? const CircularLoaderWidget()
                    : const Text(
                  'Upload this text',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
