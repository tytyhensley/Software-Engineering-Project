import 'dart:math';
import 'package:flutter/material.dart';
import 'package:aloneless_app/components/constants.dart';

class Emotion1 extends StatefulWidget {
  @override
  _Emotion1State createState() => _Emotion1State();
}

class _Emotion1State extends State<Emotion1> {
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25.0,
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'welcome_screen',
                  );
                },
                child: Transform.rotate(
                  angle: pi,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Good Morning!',
              style: kTitleTextStyle.copyWith(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'How are you feeling today?',
              style: kTitleTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
