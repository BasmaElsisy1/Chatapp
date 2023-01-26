import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/modules/baseVM.dart';
import 'package:chatapp/modules/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/room.dart';
import '../../shared/network/local/firebase_utils.dart';

class ChatVM extends BaseVM<ChatNavigator> {
  late Rooms room;
  late myUser Myuser;
  late Stream<QuerySnapshot<Message>> streamData;

  void SendMessage(String content) {
    Message message = Message(
        content: content,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        roomId: room.id,
        senderId: Myuser.id,
        senderName: Myuser.firstname);
    DataBase_Utils.addMessageToFireStore(message).then((value) {
      myNavigator!.clearContent();
    });
  }

  Stream<QuerySnapshot<Message>> ReadMessages(){
    return DataBase_Utils.getMessageFromFirebase(room.id);
  }
}
