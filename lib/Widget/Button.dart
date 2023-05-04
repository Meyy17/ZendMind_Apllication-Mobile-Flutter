// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zenmind/settings_all.dart';

Widget flatButtonPrimaryRounded(
    {required context, required String text, required Function()? onPressed}) {
  return SizedBox(
      width: double.infinity,
      height: 59,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: GetTheme().buttonColors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 0),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
          )));
}

Widget actionTextButton(
    {required String text,
    required String btnTxt,
    required Function()? onPressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      TextButton(onPressed: onPressed, child: Text(btnTxt))
    ],
  );
}

Widget googleLoginBtn(
    {required context, required String text, required Function()? onPressed}) {
  return Consumer(builder: (context, ThemeModel themeNotifier, child) {
    return SizedBox(
      height: 59,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          backgroundColor: GetTheme().backgroundGrey(context),
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
                  color: themeNotifier.isDark ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  });
}
