import 'package:chatapp/modules/baseNavigator.dart';
import 'package:flutter/material.dart';

class BaseVM<T extends BaseNavigator> extends ChangeNotifier {
  T? myNavigator = null;
}
