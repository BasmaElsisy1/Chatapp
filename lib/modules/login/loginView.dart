import 'package:chatapp/models/myuser.dart';
import 'package:chatapp/modules/baseView.dart';
import 'package:chatapp/modules/create%20account/create_account.dart';
import 'package:chatapp/modules/login/loginNavigator.dart';
import 'package:chatapp/modules/login/loginVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../shared/styles/colors.dart';
import '../home/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginVM>
    implements LoginNavigator {
  bool _isHidden = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.myNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => viewmodel,
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
              title: Text('Login'),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Welcome back!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please enter your e-mail';
                            }

                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'Please enter a valid e-mail';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text(
                                'E-mail',
                                style:
                                    TextStyle(fontSize: 12, color: grayColor),
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
                            if (text == null || text.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text(
                                'Password',
                                style:
                                    TextStyle(fontSize: 12, color: grayColor),
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
                              backgroundColor: blueColor,
                              // textStyle: TextStyle(color: grayColor)
                            ),
                            onPressed: () {
                              Login();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white , fontSize: 14),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35 , left: 20),
                  child: InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, CreateScreen.routename)},
                    child: Text(
                      'Or Create My Account',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(80, 80, 80, 1.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void Login() async {
    if (formKey.currentState?.validate() == true) {
      viewmodel.Login(emailController.text, passwordController.text);
    }
  }

  @override
  LoginVM initViewModel() {
    return LoginVM();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void goToHome(myUser Myuser) {
    var provider = Provider.of<UserProvider>(context , listen: false);
    provider.currentUserApp = Myuser;
    Navigator.popAndPushNamed(context, HomeScreen.routename);
  }
}
