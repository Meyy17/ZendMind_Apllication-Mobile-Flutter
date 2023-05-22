import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenmind/Widget/CustomLeading.dart';
import 'package:zenmind/settings_all.dart';

class TrackerMoodWidget {
  Widget chartMood({required context}) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Grafik Moodmu",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: GetTheme().backgroundGrey(context),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget listMood({required context}) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: const [
            Text(
              "Grafik Moodmu",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        leadingWithArrow(
            context: context,
            title: "Senang",
            subtitle: "Jumlah mood : 6",
            leading: templateFeelIconsNoTitle(
                bgColor: const Color(0xffEF5DA8),
                svgIconsName: 'FeelHappyIcons.svg'),
            colorWidget: const Color(0xffEF5DA8)),
        const SizedBox(
          height: 10,
        ),
        leadingWithArrow(
            context: context,
            title: "Senang",
            subtitle: "Jumlah mood : 6",
            leading: templateFeelIconsNoTitle(
                bgColor: const Color(0xffEF5DA8),
                svgIconsName: 'FeelHappyIcons.svg'),
            colorWidget: const Color(0xffEF5DA8)),
        const SizedBox(
          height: 10,
        ),
        leadingWithArrow(
            context: context,
            title: "Senang",
            subtitle: "Jumlah mood : 6",
            leading: templateFeelIconsNoTitle(
                bgColor: const Color(0xffEF5DA8),
                svgIconsName: 'FeelHappyIcons.svg'),
            colorWidget: const Color(0xffEF5DA8)),
        const SizedBox(
          height: 10,
        ),
        leadingWithArrow(
            context: context,
            title: "Senang",
            subtitle: "Jumlah mood : 6",
            leading: templateFeelIconsNoTitle(
                bgColor: const Color(0xffEF5DA8),
                svgIconsName: 'FeelHappyIcons.svg'),
            colorWidget: const Color(0xffEF5DA8)),
      ],
    );
  }
}

Widget templateFeelIconsNoTitle(
    {required Color bgColor, required String svgIconsName}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(8))),
    child: Center(
      child: SvgPicture.asset(svgAssetsLocation + svgIconsName),
    ),
  );
}
