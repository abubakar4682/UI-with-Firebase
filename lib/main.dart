import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/spleshescreen/Spleshescreen.dart';
import 'package:todoapp/view/call_image_picker.dart';
import 'package:todoapp/view/company_and_leagues_view.dart';


import 'APIs/phoonenumberr.dart';
import 'APIs/withnumber.dart';
import 'chat.dart';
import 'image_picker/home_screen.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Todo());
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class Todo extends StatelessWidget {
  const Todo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:ChatScreen()
    );
  }
}
