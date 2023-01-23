import 'package:chatapp/modules/baseVM.dart';
import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';
import 'baseNavigator.dart';

abstract class BaseView<T extends StatefulWidget, VM extends BaseVM>
    extends State<T>  implements BaseNavigator {
  late VM viewmodel;
  VM initViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel = initViewModel();
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showLoading({String message = 'Loading..'}) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: blackColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      message,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
