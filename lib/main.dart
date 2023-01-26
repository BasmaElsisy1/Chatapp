import 'package:chatapp/modules/chat/chat_screen.dart';
import 'package:chatapp/modules/create%20account/create_account.dart';
import 'package:chatapp/modules/create%20room/create_room.dart';
import 'package:chatapp/modules/home/HomeScreen.dart';
import 'package:chatapp/modules/login/loginView.dart';
import 'package:chatapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: provider.firebaseUser == null?
      LoginScreen.routename: HomeScreen.routename,
      routes: {
        LoginScreen.routename: (context) => LoginScreen(),
        CreateScreen.routename: (context) => CreateScreen(),
        HomeScreen.routename: (context) => HomeScreen(),
        CreateRoomScreen.routename: (context) => CreateRoomScreen(),
        ChatScreen.routename: (context) => ChatScreen(),
      },
    );
  }
}
