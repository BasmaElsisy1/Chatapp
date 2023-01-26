import 'package:chatapp/modules/baseView.dart';
import 'package:chatapp/modules/create%20room/create_room.dart';
import 'package:chatapp/modules/home/Homescreen-navigator.dart';
import 'package:chatapp/modules/home/Homescreen-vm.dart';
import 'package:chatapp/modules/home/room_widget.dart';
import 'package:chatapp/modules/login/loginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = 'homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeScreenVM>
    implements HomeScreen_Navigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.myNavigator = this;
    viewmodel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateRoomScreen.routename);
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routename);
                    },
                    icon: Icon(Icons.logout))
              ],
              title: Text('Chat App'),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(40),
              child: Consumer<HomeScreenVM>(
                builder: (_, homescreenviewmodel, c) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1),
                      itemCount: homescreenviewmodel.rooms.length,
                      itemBuilder: (context, index) {
                        return RoomWidget(homescreenviewmodel.rooms[index]);
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeScreenVM initViewModel() {
    return HomeScreenVM();
  }
}
