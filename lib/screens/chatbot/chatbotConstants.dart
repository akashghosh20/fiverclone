import 'package:flutter/material.dart';

const kTextFieldStyle = InputDecoration(
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    hintText: '  Ask any query?',
    hintStyle: TextStyle(color: Colors.black26));

const kAppBarColor = Color.fromARGB(255, 183, 238, 255);

const kAppbarBackground = Color.fromARGB(255, 183, 238, 255);

const kInputBorderStyle = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.blue,
    width: 1,
  ),
);

const kBorderColor = Colors.lightBlue;

const kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
  foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
);
