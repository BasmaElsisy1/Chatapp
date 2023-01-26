import 'package:chatapp/modules/baseVM.dart';
import 'package:chatapp/modules/home/Homescreen-navigator.dart';
import 'package:chatapp/shared/network/local/firebase_utils.dart';

import '../../models/room.dart';

class HomeScreenVM extends BaseVM<HomeScreen_Navigator> {
  List<Rooms> rooms = [];
  void getRooms() async {
    rooms = await DataBase_Utils.getRoomFromFirebase();
  }
}
