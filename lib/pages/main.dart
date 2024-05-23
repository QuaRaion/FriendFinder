import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
        apiKey: "AIzaSyCltK-8qocKXlIRAjve45oyo3dgD2Rh4m4",
        appId: "1:455613153926:web:eb1ef24157416b8dc40707",
        messagingSenderId: "455613153926",
        projectId: "ffproject-e5faf")
        : null,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
