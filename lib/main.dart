import 'package:chatapp/modules/create%20account/create_account.dart';
import 'package:chatapp/modules/home/HomeScreen.dart';
import 'package:chatapp/modules/login/loginView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: LoginScreen.routename,
      routes: {
        LoginScreen.routename: (context) => LoginScreen(),
        CreateScreen.routename: (context) => CreateScreen(),
        HomeScreen.routename: (context) => HomeScreen(),

      },
    );
  }
}
