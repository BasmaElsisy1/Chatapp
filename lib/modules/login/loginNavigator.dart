import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/modules/baseNavigator.dart';

abstract class LoginNavigator extends BaseNavigator{
  void goToHome(myUser MyUser);

}