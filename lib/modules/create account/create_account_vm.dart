import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/modules/baseVM.dart';
import 'package:chatapp/shared/components/firebase_errors.dart';
import 'package:chatapp/shared/network/local/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'connector.dart';

class CreateAccountViewModel extends BaseVM<Connector> {
  void CreateAccount(String email, String password, String firstname,
      String lastname, String username) async {
    try {
      myNavigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      myUser newUser = myUser(
          id: credential.user?.uid ?? '',
          email: email,
          firstname: firstname,
          lastname: lastname,
          username: username);
      myNavigator!.hideDialog();
      DataBase_Utils.adduserToFireStore(newUser);
      myNavigator!.goToHome(newUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrors.weakPassword) {
        myNavigator!.hideDialog();
        myNavigator!.showMessage('The password provided is too weak.');
      } else if (e.code == FireBaseErrors.emailInUse) {
        myNavigator!.hideDialog();
        myNavigator!.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
