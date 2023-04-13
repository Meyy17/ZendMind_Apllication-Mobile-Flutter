// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zenmind/Settings.dart';

Widget flatButtonPrimaryRounded(
    {required context, required String text, required Function()? onPressed}) {
  return SizedBox(
      width: double.infinity,
      height: 59,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: getTheme().buttonColors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 0),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
          )));
}

Widget actionTextButton({
  required String text,
  required String btnTxt,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text(text), TextButton(onPressed: () {}, child: Text(btnTxt))],
  );
}

Widget googleLoginBtn(
    {required context, required String text, required Function()? onPressed}) {
  return SizedBox(
    height: 59,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        backgroundColor: getTheme().cardColors(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('${svgAssetsLocation}IconsGoogle.svg'),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: getTheme().primaryColor(context)),
          )
        ],
      ),
    ),
  );
}
