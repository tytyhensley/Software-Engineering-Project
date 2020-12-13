import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String label;
  final TextInputType keybrd;
  final int lines;
  final TextEditingController myController;

  TextBox({
    this.label,
    @required this.keybrd,
    @required this.lines,
    this.myController,
  });
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.myController,
      maxLines: widget.lines,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      keyboardType: widget.keybrd,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          //  when the TextFormField in unfocused
        ),
      ),
    );
  }
}
