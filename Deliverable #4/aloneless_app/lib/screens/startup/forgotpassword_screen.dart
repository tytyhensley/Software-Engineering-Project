import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:aloneless_app/components/textbox.dart';
import 'package:aloneless_app/components/constants.dart';
import 'package:aloneless_app/components/regbuttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    'login_screen',
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
                'We all forget sometimes,',
                style: kAppTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Please enter email for account',
                style: kTitleTextStyle.copyWith(
                  fontSize: 21,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextBox(
                keybrd: TextInputType.emailAddress,
                lines: 1,
                myController: email,
              ),
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: WelcomeButton(
                  buttontitle: 'Submit',
                  textcolor: Color(0xFFFFFFFF),
                  onTap: () async {
                    try {
                      await _auth
                          .sendPasswordResetEmail(email: email.text)
                          .then((value) {
                        String emailtext = email.text;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              content: Text(
                                'Password reset link sent to $emailtext',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
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
                                    Navigator.pushNamed(
                                        context, 'welcome_screen');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    } catch (error) {
                      List<String> errors = error.toString().split(']');
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
