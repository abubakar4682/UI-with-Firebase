// companies_and_leagues_view_model.dart
import 'package:get/get.dart';

abstract class CompaniesAndLeaguesViewModel extends GetxController {
  void fetchCompanies();
  void fetchLeagues();
}