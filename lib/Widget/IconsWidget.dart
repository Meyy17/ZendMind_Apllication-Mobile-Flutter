// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenmind/Settings.dart';

Widget circleIconsWthBG({required context, required double size}) {
  return Container(
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
        color: getTheme().accentCardColors(context),
        borderRadius: BorderRadius.circular(100)),
    child: SvgPicture.asset(
      "${svgAssetsLocation}Icons-1.svg",
      width: size,
      height: size,
    ),
  );
}
