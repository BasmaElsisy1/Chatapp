import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/modules/baseView.dart';
import 'package:chatapp/modules/chat/chat_navigator.dart';
import 'package:chatapp/modules/chat/chat_vm.dart';
import 'package:chatapp/modules/chat/message_widget.dart';
import 'package:chatapp/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';
import '../../models/room.dart';

class ChatScreen extends StatefulWidget {
  static const String routename = 'Chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatVM>
    implements ChatNavigator {
  var messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.myNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Rooms;
    var provider = Provider.of<UserProvider>(context);
    viewmodel.room = room;
    viewmodel.Myuser = provider.currentUserApp!;
    viewmodel.ReadMessages();
    return ChangeNotifierProvider(
      create: (context) => viewmodel,
      child: Stack(
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
              actions: [],
              title: Text(room.roomName),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              width: double.infinity,
              padding: EdgeInsets.all(15),
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
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                          stream: viewmodel.ReadMessages(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }
                            var messages =
                            snapshot.data?.docs.map((doc) => doc.data()).toList();
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return Message_widget(messages![index]);
                              },
                              itemCount: messages?.length ?? 0,
                            );
                          })),
                  Container(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                                // contentPadding: EdgeInsets.zero,
                                hintText: 'Type a Messsage',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10)))),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              viewmodel.SendMessage(messageController.text);
                            },
                            child: Row(
                              children: [
                                Text('Send'),
                                SizedBox(
                                  width: 10,
                                ),
                                Transform.rotate(
                                    angle: 200,
                                    child: Icon(
                                      Icons.send,
                                      size: 15,
                                    ))
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ChatVM initViewModel() {
    return ChatVM();
  }

  @override
  void clearContent() {
    messageController.clear();
    setState(() {});
  }
}
