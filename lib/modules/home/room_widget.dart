import 'package:chatapp/models/room.dart';
import 'package:chatapp/modules/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget{
  Rooms room;
  RoomWidget(this.room);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatScreen.routename , arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/${room.catId}.jpeg", width: 86),
            SizedBox(height: 10,),
            Text(room.roomName, style: TextStyle(fontSize: 14),),
          ],
        ),
      ),
    );
  }

}