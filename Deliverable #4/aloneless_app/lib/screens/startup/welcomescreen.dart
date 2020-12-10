import 'package:flutter/cupertino.dart';
import 'package:aloneless_app/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:aloneless_app/components/regbuttons.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      child: Image.asset(
                        'assets/images/welcome.png',
                        height: 470,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 490,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'AloneLess',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Let us help you feel better today',
              style: TextStyle(
                color: kLinkColor,
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            WelcomeButton(
              buttontitle: 'Sign Up',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'registration_screen',
                );
              },
              textcolor: Color(0xFFFFFFFF),
            ),
            GestureDetector(
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
          ],
        ),
      ),
    );
  }
}
