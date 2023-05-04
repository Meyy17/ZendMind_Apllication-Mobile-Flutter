import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/settings_all.dart';

class ConsultationWidget {
  Widget needHandleList({required context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What do you need to handle?",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            templateFeatList(
                context: context,
                title: "Anxiety",
                locationSvgAssets: "ConsultationIcons.svg"),
            templateFeatList(
                context: context,
                title: "Down",
                locationSvgAssets: "ConsultationIcons.svg"),
            templateFeatList(
                context: context,
                title: "Depression",
                locationSvgAssets: "ConsultationIcons.svg"),
            templateFeatList(
                context: context,
                title: "Self Harm",
                locationSvgAssets: "ConsultationIcons.svg"),
          ],
        )
      ],
    );
  }

  Widget recomendation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recomendation",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: index % 2 != 0
                      ? const Color(0xffF5F5DA)
                      : const Color(0xffACD8FE)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: GetTheme().backgroundGrey(context)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Lugas Richtigo",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 15),
                          ),
                          Text(
                            "Specialist :",
                            style: TextStyle(
                                fontSize: 10,
                                color: GetTheme().unselectedWidget(context)),
                          ),
                          Text("Anxiety",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: GetTheme().unselectedWidget(context)))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: GetTheme().cardColors(context)),
                            child: const Icon(
                              Icons.timer,
                              size: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Avaliable Anytime",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                        width: 119,
                        child: flatButtonPrimaryRounded(
                            context: context,
                            text: "Book now",
                            onPressed: () {}),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
        ),
      ],
    );
  }
}

Widget templateFeatList(
    {required String title,
    required String locationSvgAssets,
    required context}) {
  return Column(
    children: [
      SizedBox(
        width: GetSizeScreen().width(context) * 0.2,
        height: GetSizeScreen().width(context) * 0.2,
        child: SvgPicture.asset(svgAssetsLocation + locationSvgAssets),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(title)
    ],
  );
}
