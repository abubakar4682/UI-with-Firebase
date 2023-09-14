import 'package:flutter/material.dart';

class AppUrl {
  static const String baseUrl =
      'https://inobackend-production.up.railway.app/api/v1';
  static const String registerUrl = '$baseUrl/user/register';
  static const String otpUrl = '$baseUrl/user/verifyOTP';
}
