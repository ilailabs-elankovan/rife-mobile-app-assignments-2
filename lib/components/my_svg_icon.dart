import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MySvgIcon extends StatelessWidget {
  final String iconUrl;
  final Color? iconColor;
  final double? iconSize;
  MySvgIcon({super.key, required this.iconUrl, this.iconColor, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: iconSize ?? 16.0,
      width: iconSize ?? 16.0,
      child: SvgPicture.asset(iconUrl, color: iconColor ?? greyIconColor,),
    );;
  }
}
