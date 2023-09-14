// company_and_leagues_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'companies_and_leagues_viewmodelImpl.dart';

class CompanyAndLeaguesView extends StatelessWidget {
  final _companiesAndLeaguesViewModel = Get.put(CompaniesAndLeaguesViewModelImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies and Leagues Dropdowns'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
                  () => _companiesAndLeaguesViewModel.companies.isEmpty
                  ? CircularProgressIndicator() // Show a loading indicator while companies data is being fetched
                  : DropdownButtonFormField<String>(
                value: _companiesAndLeaguesViewModel.companies[0].name,
                onChanged: (newValue) {
                  // Handle onChanged if needed
                },
                items: _companiesAndLeaguesViewModel.companies.map<DropdownMenuItem<String>>((company) {
                  return DropdownMenuItem<String>(
                    value: company.name,
                    child: Text(company.name),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select a Company',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(
                  () => _companiesAndLeaguesViewModel.leagues.isEmpty
                  ? CircularProgressIndicator() // Show a loading indicator while leagues data is being fetched
                  : DropdownButtonFormField<String>(
                value: _companiesAndLeaguesViewModel.leagues[0].name,
                onChanged: (newValue) {
                  // Handle onChanged if needed
                },
                items: _companiesAndLeaguesViewModel.leagues.map<DropdownMenuItem<String>>((league) {
                  return DropdownMenuItem<String>(
                    value: league.name,
                    child: Text(league.name),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select a League',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
