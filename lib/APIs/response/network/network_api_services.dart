import 'dart:convert';
import 'dart:io';

import '../../../exceptions/exception.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    print(url);
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 1));
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException();
    }
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data))
          .timeout(Duration(seconds: 1));
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException();
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw UnknownException();
    }
  }
}
