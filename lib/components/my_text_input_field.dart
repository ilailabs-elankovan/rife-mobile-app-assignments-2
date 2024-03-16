import 'package:flutter/material.dart';

class MyTextInputField extends StatelessWidget {
  var hint;
  var controller;
  var isObscureText;
  var bgColor;

  MyTextInputField({Key? key, required this.hint, required this.controller, required this.isObscureText, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      controller: controller,
        obscureText: isObscureText,
        cursorColor: Colors.blueGrey,
        decoration: new InputDecoration(
            enabledBorder: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.blue, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            // labelText: hint,
            hintText: hint,
            hintStyle: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400, fontSize: 16.0),
            labelStyle: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w400, fontSize: 16.0),
            filled: true,
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(7.0),
              borderSide: new BorderSide(
                  color: Colors.blueGrey
              ),
            )));
  }
}

