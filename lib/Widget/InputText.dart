// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:zenmind/settings_all.dart';

Widget inputStyleFillWithIcons(
    {required context,
    required String hintText,
    required Icon prefixIcons,
    required TextEditingController controller,
    required bool readOnly,
    required bool inputVisibilty,
    required String? Function(String?)? validator}) {
  return TextFormField(
    readOnly: readOnly,
    validator: validator,
    obscureText: inputVisibilty,
    controller: controller,
    decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: prefixIcons,
        filled: true,
        fillColor: GetTheme().backgroundGrey(context),
        hintStyle: const TextStyle(fontSize: 13),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        hintText: hintText),
  );
}
