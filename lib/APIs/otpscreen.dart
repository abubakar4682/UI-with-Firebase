import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/APIs/phoonenumberr.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;

  OTPScreen({ required this.mobileNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  RegistrationScreen clas=RegistrationScreen();
  static const String TOKEN ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     gettoken();
  }
  void verifyOTP() async {
    final String apiEndpoint =
        'https://inobackend-production.up.railway.app/api/v1/user/verifyOTP';

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      "mobileNumber": widget.mobileNumber,
      "otp": otpController.text,
    };

    // Send the POST request
    try {
      final response = await http.post(Uri.parse(apiEndpoint),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(requestBody));


      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);


        String token = responseData['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(TOKEN, token);


        print(responseData['message']);
        print(responseData['token']);

      } else {

        print('Error: ${response.statusCode}');
        print('Message: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occurred during the request
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: verifyOTP,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void gettoken() async {
    var pref=  await SharedPreferences.getInstance();
    var gettoken = pref.getString(TOKEN);
    var showtoken=gettoken;
    setState(() {

    });
    print(showtoken);

  }
}
