import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/modules/baseVM.dart';
import 'package:chatapp/modules/login/loginNavigator.dart';
import 'package:chatapp/shared/network/local/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginVM extends BaseVM<LoginNavigator> {
  void Login(String email, String password) async {
    try {
      myNavigator!.showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      myUser? MyUser =
          await DataBase_Utils.getDataFromFireStore(credential.user?.uid ?? '');

      if (MyUser != null) {
        myNavigator!.goToHome(MyUser);
      }
      else{

        myNavigator!.showMessage('user not found');
      }
      myNavigator!.hideDialog();
    } on FirebaseAuthException catch (e) {
      myNavigator!.hideDialog();
      myNavigator!.showMessage('Wrong Email or Password.');
    } catch (e) {
      print(e);
    }
  }
}
