import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/room.dart';

class DataBase_Utils {
  static CollectionReference<myUser> getuserCollections() {
    return FirebaseFirestore.instance.collection('Users').withConverter<myUser>(
        fromFirestore: ((snapshot, _) => myUser.fromJson(snapshot.data()!)),
        toFirestore: (value, _) => value.toJson());
  }

  static Future<void> adduserToFireStore(myUser newUser) {
    return getuserCollections().doc(newUser.id).set(newUser);
  }

  static Future<myUser?> getDataFromFireStore(String id) async {
    DocumentSnapshot<myUser> userRef = await getuserCollections().doc(id).get();

    return userRef.data();
  }

  static CollectionReference<Rooms> getroomsCollections() {
    return FirebaseFirestore.instance.collection('Rooms').withConverter<Rooms>(
        fromFirestore: ((snapshot, options) =>
            Rooms.fromJson(snapshot.data()!)),
        toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addRoomToFireStore(Rooms room) {
    var collection = getroomsCollections();
    var documentref = collection.doc();
    room.id = documentref.id;
    return documentref.set(room);
  }

  static Future<List<Rooms>> getRoomFromFirebase() async {
    var snapShotRoom = await getroomsCollections().get();
    List<Rooms> rooms = snapShotRoom.docs.map((doc) => doc.data()).toList();
    return rooms;
  }

  static CollectionReference<Message> getMessagesCollections(String RoomId) {
    return getroomsCollections()
        .doc(RoomId)
        .collection('Messages')
        .withConverter<Message>(
            fromFirestore: ((snapshot, options) =>
                Message.fromJson(snapshot.data()!)),
            toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addMessageToFireStore(Message message) {
    var collection = getMessagesCollections(message.roomId);
    var documentref = collection.doc();
    message.id = documentref.id;
    return documentref.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessageFromFirebase(String roomId) {
    return getMessagesCollections(roomId).orderBy('dateTime').snapshots();
  }
}
