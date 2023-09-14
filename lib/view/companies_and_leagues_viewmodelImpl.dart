import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../APIs/controllers/companies_and_leagues_view_model.dart';
import '../exceptions/error_handling.dart';
import '../model/company_model.dart';
import '../model/league_model.dart';
class CompaniesAndLeaguesViewModelImpl extends CompaniesAndLeaguesViewModel {
  final _companies = <Company>[].obs;
  List<Company> get companies => _companies;

  final _leagues = <League>[].obs;
  List<League> get leagues => _leagues;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
    fetchLeagues();
  }

  @override
  void fetchCompanies() async {
    const tokenUrl = 'http://78.46.90.147:80/api/v1/data/gettoken';
    const companiesUrl = 'http://78.46.90.147:80/api/v1/data/getallcompanies';
    const username = 'dtechraabit';
    const password = 'admin123';

    try {
      // Step 1: Call the token API to get the access token
      final tokenResponse = await http.post(
        Uri.parse(tokenUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (tokenResponse.statusCode == 200) {
        final tokenData = jsonDecode(tokenResponse.body);
        final accessToken = tokenData['data']['access_token'];

        // Step 2: Use the access token to make the companies API call
        final companiesResponse = await http.get(
          Uri.parse(companiesUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (companiesResponse.statusCode == 200) {
          final companiesData = jsonDecode(companiesResponse.body);
          _companies.assignAll(List<Map<String, dynamic>>.from(companiesData['data']).map((json) => Company.fromJson(json)));
        } else {
          // Handle error using the error handling service
          ErrorHandlingService.handleApiError(companiesResponse.statusCode);
        }
      } else {
        // Handle error using the error handling service
        ErrorHandlingService.handleApiError(tokenResponse.statusCode);
      }
    } catch (e) {
      // Handle error using the error handling service
      ErrorHandlingService.handleOtherError(e);
    }
  }

  @override
  void fetchLeagues() async {
    const tokenUrl = 'http://78.46.90.147:80/api/v1/data/gettoken';
    final leaguesUrl = 'http://78.46.90.147:80/api/v1/data/getallleagues';
    final username = 'dtechraabit';
    final password = 'admin123';

    try {
      // Step 1: Call the token API to get the access token
      final tokenResponse = await http.post(
        Uri.parse(tokenUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (tokenResponse.statusCode == 200) {
        final tokenData = jsonDecode(tokenResponse.body);
        final accessToken = tokenData['data']['access_token'];

        // Step 2: Use the access token to make the leagues API call
        final leaguesResponse = await http.get(
          Uri.parse(leaguesUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (leaguesResponse.statusCode == 200) {
          final leaguesData = jsonDecode(leaguesResponse.body);
          _leagues.assignAll(List<Map<String, dynamic>>.from(leaguesData['data']).map((json) => League.fromJson(json)));
        } else {
          // Handle error using the error handling service
          ErrorHandlingService.handleApiError(leaguesResponse.statusCode);
        }
      } else {
        // Handle error using the error handling service
        ErrorHandlingService.handleApiError(tokenResponse.statusCode);
      }
    } catch (e) {
      // Handle error using the error handling service
      ErrorHandlingService.handleOtherError(e);
    }
  }
}
