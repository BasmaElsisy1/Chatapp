import 'package:chatapp/models/message.dart';
import 'package:chatapp/providers/user_provider.dart';
import 'package:chatapp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Message_widget extends StatelessWidget {
  Message message;
  Message_widget(this.message);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.currentUserApp!.id == message.senderId
        ? Sender(message)
        : Reciever(message);
  }
}

class Sender extends StatelessWidget {
  Message message;
  Sender(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          message.senderName,
          style: TextStyle(color: graylightColor, fontSize: 12),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              date.substring(12),
              style: TextStyle(fontSize: 10, color: Colors.black),
              textAlign: TextAlign.start,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 13),
              margin: EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.zero,
                      bottomLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12))),
              child: Text(
                message.content,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Reciever extends StatelessWidget {
  Message message;
  Reciever(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.senderName,
          style: TextStyle(color: graylightColor, fontSize: 12),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              date.substring(12),
              style: TextStyle(fontSize: 10, color: Colors.black),
              textAlign: TextAlign.start,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 13),
              margin: EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                  color:graylightColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.zero,
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12))),
              child: Text(
                message.content,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
