import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routename = 'homescreen';

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          child: Image.asset(
            'assets/images/main_bg.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () => {

                },
                child: Text('signout'),
              )
            ],
            title: Text('Chat App'),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
      ],
    );
  }

}
