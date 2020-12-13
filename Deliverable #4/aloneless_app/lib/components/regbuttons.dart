import 'package:flutter/material.dart';
import 'package:aloneless_app/components/constants.dart';

class WelcomeButton extends StatelessWidget {
  WelcomeButton(
      {@required this.buttontitle,
      @required this.onTap,
      @required this.textcolor});

  final Color textcolor;
  final String buttontitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: RaisedButton(
          onPressed: onTap,
          color: kbuttonColor,
          disabledColor: Color(0xFF000000),
          padding: EdgeInsets.all(15.0),
          child: Text(
            buttontitle,
            style: TextStyle(
              color: textcolor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
