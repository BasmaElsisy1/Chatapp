import 'package:chatapp/models/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase_Utils {
  static CollectionReference<myUser> getuserCollections() {
    return FirebaseFirestore.instance.collection('Users').withConverter<myUser>(
        fromFirestore: ((snapshot, options) =>
            myUser.fromJson(snapshot.data()!)),
        toFirestore: (value, options) => value.toJson());
  }

  static Future<void> adduserToFireStore(myUser newUser) {
    var collection = getuserCollections();
    var documentref = collection.doc();
    newUser.id = documentref.id;
    return documentref.set(newUser);
  }
static Future<myUser?> getDataFromFireStore(String id) async{
    var userRef = await getuserCollections().doc(id).get();

    return userRef.data();
}
  // Stream<QuerySnapshot<myUser>> getDataFromFireStore(String id) {
  //   return getuserCollections()
  //       .where('date', isEqualTo: date.microsecondsSinceEpoch)
  //       .snapshots();
  // }
}

// Stream<QuerySnapshot<Task>> getDataFromFireStore(DateTime date) {
//   return getTasksCollections()
//       .where('date', isEqualTo: date.microsecondsSinceEpoch)
//       .snapshots();
// }
//
// Future<void> deleteTasksFromFireStore(String id) {
//   return getTasksCollections().doc(id).delete();
// }
//
// Future<void> ChangeDone(String id) {
//   return getTasksCollections().doc(id).update({"isDone": true});
// }
//
// Future<void> Edit(String id, String title, int date ) {
//   return getTasksCollections().doc(id).update({"title": title , "date" : date});
// }
