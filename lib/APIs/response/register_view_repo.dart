import 'package:flutter/material.dart';

import 'app_urls.dart';
import 'network/base_api_services.dart';
import 'network/network_api_services.dart';

class RegisterRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> registerApi(Map<String, dynamic> data) async {
    final response = await _apiServices.postApi(data, AppUrl.registerUrl);
    return response;
  }

  Future<dynamic> otpApi(Map<String, dynamic> data) async {
    final response = await _apiServices.postApi(data, AppUrl.otpUrl);
    return response;
  }
}
