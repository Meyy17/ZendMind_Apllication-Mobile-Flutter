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

Widget dateCard(
    {required String day,
    required String date,
    required Function()? onPressed}) {
  return Container(
    width: 50,
    height: 75,
    decoration: BoxDecoration(
        color: const Color(0xFFF1F6F7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
          width: 1,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF5C5C5C),
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        )
      ],
    ),
  );
}

Widget timePicker({required String time, required Function()? onPressed}) {
  return Container(
    height: 50,
    width: 125,
    decoration: BoxDecoration(
      color: const Color(0xFFF1F6F7),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: const Color(0xFFE3E3E3),
        width: 1,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
