import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class   MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _textEditingController = TextEditingController();
  String _submittedText = '';
  static const String KEYNAME = "name";
  var namevale = "";

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter something...',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var name = _textEditingController.text.toString();
                var prefs = await SharedPreferences.getInstance();
                prefs.setString(KEYNAME, name);
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(
              'Submitted Text: $namevale',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void getdata() async {
    var prefs = await SharedPreferences.getInstance();
    var getname = prefs.getString(KEYNAME);
    namevale = getname!;
    setState(() {});
  }
}
