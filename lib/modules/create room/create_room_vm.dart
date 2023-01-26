import 'package:chatapp/models/room.dart';
import 'package:chatapp/modules/baseVM.dart';
import 'package:chatapp/modules/create%20room/create_room_navigator.dart';
import 'package:chatapp/shared/network/local/firebase_utils.dart';

class CreateRoomVM extends BaseVM<CreateRoomNavigator> {
  void createRoom(String roomName, String roomDescription, String catId) {
    Rooms room = Rooms(
        roomName: roomName, roomDescription: roomDescription, catId: catId);
    DataBase_Utils.addRoomToFireStore(room).then((value) {
      myNavigator?.roomCreated();

    }).catchError((error) {
      myNavigator?.showMessage('Cannot be added');
    });
  }
}
