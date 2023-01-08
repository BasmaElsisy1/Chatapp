import 'package:chatapp/modules/create%20account/create_account_vm.dart';
import 'package:chatapp/shared/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../shared/components/ui_utilities.dart';

class CreateScreen extends StatefulWidget {
  static const String routename = 'Create_account';

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool _isHidden = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  CreateAccountViewModel createAccountViewModel = CreateAccountViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => createAccountViewModel,
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
              title: Text('Create Account'),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (text) {
                        if (text != null && text.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                            'First Name',
                            style: TextStyle(fontSize: 12, color: grayColor),
                          ),
                          hintText: 'First Name'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text != null && text.isEmpty) {
                          return 'Please enter your Last name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                            'Last Name',
                            style: TextStyle(fontSize: 12, color: grayColor),
                          ),
                          hintText: 'Last Name'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text != null && text.isEmpty) {
                          return 'Please enter your User name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                            'User Name',
                            style: TextStyle(fontSize: 12, color: grayColor),
                          ),
                          hintText: 'User name'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text != null && text.isEmpty) {
                          return 'Please enter your e-mail';
                        }

                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text!);
                        if (!emailValid) {
                          return 'Please enter a valid e-mail';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                            'E-mail',
                            style: TextStyle(fontSize: 12, color: grayColor),
                          ),
                          hintText: 'Email'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isHidden,
                      validator: (text) {
                        if (text != null && text.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                            'Password',
                            style: TextStyle(fontSize: 12, color: grayColor),
                          ),
                          hintText: 'Password',
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              Icons.visibility_outlined,
                              color: blueColor,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          // textStyle: TextStyle(color: grayColor)
                        ),
                        onPressed: () {
                          createAccount();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(color: graylightColor),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: graylightColor,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createAccount() async {
    if (formKey.currentState!.validate()) {
      createAccountViewModel.CreateAccount(
          emailController.text, passwordController.text);
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
