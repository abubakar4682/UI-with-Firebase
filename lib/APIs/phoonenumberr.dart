import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'controllers/response_controller.dart';
import 'otpscreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final registercontroller = Get.put(RegisterViewController());

  @override
  Widget build(BuildContext context) {
    print('rebulit');
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: registercontroller.mobileNumberController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              SizedBox(height: 16),
              // Show CircularProgressIndicator if loading is true
              registercontroller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
          onPressed: () {
          registercontroller.registerUser();
          },
          child: Text('Register'),
          ),
            ],
          );
        }),
      ),
    );
  }
}










// void registerUser() async {
//   var name=mobileNumberController.text.toString();
//   final String apiEndpoint =
//       'https://inobackend-production.up.railway.app/api/v1/user/register';
//
//   // Prepare the request body
//   Map<String, dynamic> requestBody = {
//     "mobileNumber": mobileNumberController.text,
//   };
//
//   // Send the POST request
//   try {
//     final response = await http.post(Uri.parse(apiEndpoint),
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: json.encode(requestBody));
//
//     // Check if the request was successful
//     if (response.statusCode == 200) {
//       // If the response code is 200, the user was created successfully
//       final responseData = json.decode(response.body);
//       // You can access the user data using responseData['result']
//
//       // Show a success message or perform any other actions here
//       Get.to(OTPScreen(mobileNumber:mobileNumberController.text.toString() ,));
//       print(responseData['responseMessage']);
//     } else {
//       // If the request was not successful, handle the error here
//       print('Error: ${response.statusCode}');
//       print('Message: ${response.body}');
//     }
//   } catch (e) {
//     // Handle any exceptions that occurred during the request
//     print('Error: $e');
//   }
// }
