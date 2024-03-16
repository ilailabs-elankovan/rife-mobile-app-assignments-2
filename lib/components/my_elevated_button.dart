import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  var onPressed;
  Widget child;
  MyElevatedButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 54.0,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff0080f3),
              textStyle: TextStyle(color: Colors.white, fontFamily: 'Nunito', fontSize: 16.0)
            )
            ,
            onPressed: onPressed, child: child));
  }
}
