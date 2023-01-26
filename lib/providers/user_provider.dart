import 'package:chatapp/shared/network/local/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/myuser.dart';

class UserProvider extends ChangeNotifier {
  myUser? currentUserApp;
  User? firebaseUser;

  UserProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }
  void initUser() async {
    if (firebaseUser != null) {
      currentUserApp = await DataBase_Utils.getDataFromFireStore(firebaseUser?.uid??'');
      print("basma ${currentUserApp?.firstname}");
    }
  }
  //
  // void initUser(User user) {
  //   firebaseUser = user;
  // }
}
