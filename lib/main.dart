import 'package:documentsuploader/ui/authentication/loginpage.dart';
import 'package:documentsuploader/ui/authentication/registerpage.dart';
import 'package:documentsuploader/ui/homepage/Home.dart';
import 'package:documentsuploader/ui/items/documents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
