import 'package:flutter/material.dart';
import 'package:aloneless_app/components/constants.dart';
import 'package:aloneless_app/components/textbox.dart';
import 'package:aloneless_app/components/passwordtextbox.dart';
import 'package:aloneless_app/components/regbuttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  final DatabaseReference _addUser =
      FirebaseDatabase.instance.reference().child('Users');

  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  bool showSpinner = false;
  List<String> errors;

  checkTextFieldEmptyOrNot() {
    String text1, text2, text3;

    text1 = email.text;
    text2 = password.text;
    text3 = cpassword.text;

    if (text1 == '' || text2 == '' || text3 == '') {
      return false;
    } else {
      return true;
    }
  }

  checkPasswordSame() {
    String text1, text2;

    text1 = password.text;
    text2 = cpassword.text;

    if (text1 == text2) {
      return true;
    } else {
      return false;
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
                  'Sign Up',
                  style: kTitleTextStyle.copyWith(
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextBox(
                  label: 'EMAIL',
                  keybrd: TextInputType.emailAddress,
                  lines: 1,
                  myController: email,
                ),
                SizedBox(
                  height: 10.0,
                ),
                PasswordTextBox(
                  label: 'PASSWORD',
                  keybrd: TextInputType.visiblePassword,
                  lines: 1,
                  myController: password,
                ),
                SizedBox(
                  height: 10.0,
                ),
                PasswordTextBox(
                  label: 'CONFIRM PASSWORD',
                  keybrd: TextInputType.visiblePassword,
                  lines: 1,
                  myController: cpassword,
                ),
                SizedBox(
                  height: 60.0,
                ),
                Center(
                  child: WelcomeButton(
                    buttontitle: 'Next',
                    textcolor: Color(0xFFFFFFFF),
                    onTap: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (checkPasswordSame() == true) {
                        if (checkTextFieldEmptyOrNot() == true) {
                          try {
                            await _auth
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text)
                                .then((value) {
                              loggedInUser = _auth.currentUser;
                              _addUser.child(loggedInUser.uid).set({
                                'email': email.text,
                              });
                              setState(() {
                                showSpinner = false;
                              });
                              Navigator.pushNamed(
                                context,
                                'calendar_screen',
                              );
                            });
                          } catch (error) {
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
                                "Passwords don't match",
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
                        'login_screen',
                      );
                    },
                    child: Text(
                      'Already have an account? Sign In',
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
