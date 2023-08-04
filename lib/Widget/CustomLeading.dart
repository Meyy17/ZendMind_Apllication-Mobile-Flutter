// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/settings_all.dart';

Widget leadingWithArrow(
    {required context,
    required Widget leading,
    required Color colorWidget,
    required String title,
    required String subtitle}) {
  double heightContainer = 77;
  double borderRadius = 10;
  return Container(
    height: heightContainer,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: GetTheme().backgroundGrey(context))),
    width: GetSizeScreen().width(context),
    child: Row(
      children: [
        Container(
          width: GetSizeScreen().width(context) * 0.02,
          height: heightContainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                bottomLeft: Radius.circular(borderRadius)),
            color: colorWidget,
          ),
        ),
        Expanded(
            child: ListTile(
          leading: leading,
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 10),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
          ),
        ))
      ],
    ),
  );
}

Widget leadingWithArrowAndShimmer(
    {required context,
    required Widget leading,
    required bool isLoad,
    required Color colorWidget,
    required String title,
    required String subtitle}) {
  double heightContainer = 77;
  double borderRadius = 10;
  return Container(
    height: heightContainer,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: GetTheme().backgroundGrey(context))),
    width: GetSizeScreen().width(context),
    child: Row(
      children: [
        Container(
          width: GetSizeScreen().width(context) * 0.02,
          height: heightContainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                bottomLeft: Radius.circular(borderRadius)),
            color: colorWidget,
          ),
        ),
        Expanded(
            child: ListTile(
          leading: leading,
          title: isLoad
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[350]!,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
          subtitle: isLoad
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[350]!,
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10),
                  ),
                )
              : Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10),
                ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
          ),
        ))
      ],
    ),
  );
}
