import 'package:flutter/material.dart';
import 'package:aloneless_app/components/textbox.dart';
import 'package:aloneless_app/components/passwordtextbox.dart';
import 'package:aloneless_app/components/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aloneless_app/components/regbuttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  bool showSpinner = false;
  List<String> errors;

  checkTextFieldEmptyOrNot() {
    String text1, text2;

    text1 = email.text;
    text2 = password.text;
    if (text1 == '' || text2 == '') {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'welcome_screen',
                    );
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Sign In',
                  style: kTitleTextStyle.copyWith(
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextBox(
                  label: 'EMAIL ADDRESS',
                  keybrd: TextInputType.emailAddress,
                  lines: 1,
                  myController: email,
                ),
                SizedBox(
                  height: 40.0,
                ),
                PasswordTextBox(
                  label: 'PASSWORD',
                  keybrd: TextInputType.visiblePassword,
                  lines: 1,
                  myController: password,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    child: Text(
                      'Forgot password',
                      style: kAppTextStyle.copyWith(
                        fontSize: 14.0,
                        color: kLinkColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'forgotpass_screen');
                    },
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Center(
                  child: WelcomeButton(
                    buttontitle: 'Next',
                    textcolor: Color(0xFFFFFFFF),
                    onTap: () async {
                      if (checkTextFieldEmptyOrNot() == true) {
                        try {
                          setState(() {
                            showSpinner = true;
                          });
                          await _auth
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text)
                              .then((value) {
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.pushNamed(context, 'calendar_screen');
                          });
                        } catch (error) {
                          setState(() {
                            showSpinner = false;
                          });
                          errors = error.toString().split(']');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: Text(
                                  "Uh-Oh",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  errors[1],
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: Text(
                                "Uh-Oh",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                "Please fill in all text fields",
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'registration_screen',
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: kAppTextStyle.copyWith(
                        color: kLinkColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
