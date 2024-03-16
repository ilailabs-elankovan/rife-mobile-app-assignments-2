import 'package:flutter/material.dart';
import 'package:rife_mobile_app/components/my_svg_icon.dart';

import '../utils/constants.dart';

class MyIssueSelectorCard extends StatefulWidget {
  var title;
  MyIssueSelectorCard({super.key, required this.title});

  @override
  State<MyIssueSelectorCard> createState() => _MyIssueSelectorCardState();
}

class _MyIssueSelectorCardState extends State<MyIssueSelectorCard> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: (){
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: !_isSelected ? Colors.white : faqTitleBgColor,
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              border: Border.all(width: 0.75, color: Colors.blueGrey)),
          padding: const EdgeInsets.all(8),
          // color: Colors.teal[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (_isSelected) ? SizedBox(
                width: 14.0,
                  height: 14.0,
                  child: MySvgIcon(iconUrl: 'assets/icons/check_encircled_icon.svg', iconColor: Colors.black, iconSize: 14,)):SizedBox(width: 14.0, height: 14.0,),
              Text(
                widget.title,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0),
              ),
              SizedBox(
                width: 14,
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
