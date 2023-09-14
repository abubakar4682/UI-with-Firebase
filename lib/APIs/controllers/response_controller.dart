import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../exceptions/exception.dart';
import '../otpscreen.dart';
import '../response/app_urls.dart';
import '../response/register_view_repo.dart';
import 'package:http/http.dart'as http;

class RegisterViewController extends GetxController {
  final repository = RegisterRepository();

  final mobileNumberController = TextEditingController();


  final otpController = TextEditingController();
  RxBool loading = false.obs;

  // final SharedPreferencesService sharedPreferencesService =
  // SharedPreferencesService();
  void registerUser() async {
    loading.value = true;
    // var name=mobileNumberController.text.toString();
  final String apiEndpoint =
      'https://inobackend-production.up.railway.app/api/v1/user/register';

  // Prepare the request body
  Map<String, dynamic> requestBody = {

    "mobileNumber": mobileNumberController.text,
  };

  // Send the POST request
  try {
    final response = await http.post(Uri.parse(apiEndpoint),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(requestBody));

    // Check if the request was successful
    if (response.statusCode == 200) {

      // If the response code is 200, the user was created successfully
      final responseData = json.decode(response.body);
      // You can access the user data using responseData['result']

      // Show a success message or perform any other actions here
      Get.to(OTPScreen(mobileNumber:mobileNumberController.text.toString() ,));
      print(responseData['responseMessage']);
    } else {
      // If the request was not successful, handle the error here
      print('Error: ${response.statusCode}');
      print('Message: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the request
    print('Error: $e');
  }
    loading.value = false;
}

}
