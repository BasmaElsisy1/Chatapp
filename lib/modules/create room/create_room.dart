import 'package:chatapp/models/categories.dart';
import 'package:chatapp/modules/baseView.dart';
import 'package:chatapp/modules/create%20room/create_room_navigator.dart';
import 'package:chatapp/modules/create%20room/create_room_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/styles/colors.dart';
import '../home/HomeScreen.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routename = 'CreateRoom';

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends BaseView<CreateRoomScreen, CreateRoomVM>
    implements CreateRoomNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var roomNameController = TextEditingController();
  var roomDescController = TextEditingController();
  var room_categories = Category.getCategories();
  late Category category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.myNavigator = this;
    category = room_categories.first;
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
            appBar: AppBar(
              actions: [],
              title: Text('Chat App'),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              padding: EdgeInsets.all(25),
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
                  Text(
                    'Create New Room',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 24, bottom: 50),
                      child:
                          Image.asset('assets/images/create-chat-image.png')),
                  Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: roomNameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please enter room name';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text(
                                  '',
                                  style:
                                      TextStyle(fontSize: 12, color: grayColor),
                                ),
                                hintText: 'Enter Room Name',
                                hintStyle: TextStyle(color: graylightColor)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButton<Category>(
                            isExpanded: true,
                            value: category,
                            items: room_categories
                                .map((e) => DropdownMenuItem<Category>(
                                    value: e,
                                    child: Row(
                                      children: [
                                        // Image.asset(e.image),
                                        Text(e.name)
                                      ],
                                    )))
                                .toList(),
                            onChanged: (value) {
                              category = value!;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: roomDescController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please enter room description';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text(
                                '',
                                style:
                                    TextStyle(fontSize: 12, color: grayColor),
                              ),
                              hintText: 'Enter Room Descreption',
                              hintStyle: TextStyle(color: graylightColor),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: blueColor),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0.0),
                                onPressed: () {
                                  ValidateForm();
                                },
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ValidateForm() {
    if (formKey.currentState?.validate() == true) {
      viewmodel.createRoom(
          roomNameController.text, roomDescController.text, category.id);
    }
  }

  @override
  CreateRoomVM initViewModel() {
    return CreateRoomVM();
  }

  @override
  void roomCreated() {
    Navigator.pop(context);
    setState(() {
      
    });
  }
}
