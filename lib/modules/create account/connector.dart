import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/modules/baseNavigator.dart';

abstract class Connector extends BaseNavigator{
  void goToHome(myUser user);

}