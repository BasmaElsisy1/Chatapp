import 'package:chatapp/shared/components/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountViewModel extends ChangeNotifier{

  void CreateAccount(String email , String password) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrors.weakPassword) {
        print('The password provided is too weak.');
      } else if (e.code == FireBaseErrors.emailInUse) {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}