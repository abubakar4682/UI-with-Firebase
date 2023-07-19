import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/view/login.dart';
import 'package:todoapp/view/login_with_number.dart';

import 'package:todoapp/view/postscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/view/shopping_page.dart';
import 'package:todoapp/view/update.dart';

import 'firestore/firestore_screen.dart';

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
      home: ShoppingPage(),
    );
  }
}
