import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenmind/Widget/CustomLeading.dart';
import 'package:zenmind/settings_all.dart';

class HomeWidget {
  Widget header({
    context,
    required String greeting,
    required String username,
    required double paddingScreen,
  }) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$greeting, ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Text(
                username,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )),
        Container(
          margin: const EdgeInsets.only(left: 40),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            color: GetTheme().primaryColor(context),
          ),
          child: const Center(
            child: Icon(
              Icons.notifications,
              size: 27,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget action({
    context,
    required double paddingScreen,
  }) {
    return Padding(
      padding: EdgeInsets.all(paddingScreen),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you feel today?",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                templateFeelIcons(
                    caption: 'Happy',
                    bgColor: const Color(0xffEF5DA8),
                    svgIconsName: 'FeelHappyIcons.svg'),
                templateFeelIcons(
                    caption: 'Normal',
                    bgColor: const Color(0xff00CE90),
                    svgIconsName: 'FeelNormalIcons.svg'),
                templateFeelIcons(
                    caption: 'Sad',
                    bgColor: const Color(0xff4DCCC1),
                    svgIconsName: 'FeelSadIcons.svg'),
                templateFeelIcons(
                    caption: 'Angry',
                    bgColor: const Color(0xffFF696B),
                    svgIconsName: 'FeelAngryIcons.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget featMentalHealth({
    context,
    required double paddingScreen,
  }) {
    return Padding(
      padding: EdgeInsets.all(paddingScreen),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overcoming Mental Health Disorders",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                templateFeatList(
                    context: context,
                    title: "Consultation",
                    locationSvgAssets: "ConsultationIcons.svg"),
                templateFeatList(
                    context: context,
                    title: "Meditasi",
                    locationSvgAssets: "ConsultationIcons.svg"),
                templateFeatList(
                    context: context,
                    title: "Bubble Breath",
                    locationSvgAssets: "ConsultationIcons.svg"),
                templateFeatList(
                    context: context,
                    title: "Article",
                    locationSvgAssets: "ConsultationIcons.svg"),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Widget about mental health
  Widget aboutMentalHealth({context, required double paddingScreen}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingScreen),
      child: Column(
        children: [
          templateTitleHome(
              context: context,
              title: "About Mental Health",
              icons: Icon(
                Icons.info_outline_rounded,
                color: GetTheme().themeColor,
              ),
              subtitle: "education on mental health"),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff4DCCC1),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('${svgAssetsLocation}ArtMentalHealthHome.svg'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mental health",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                            "Find out about the importance of mental health",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            )),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: Colors.white,
                                elevation: 0),
                            child: const Text("Find out !"))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget recomendationMeditasi({context, required double paddingScreen}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingScreen),
          child: templateTitleHome(
              context: context,
              title: "Recomendasi Meditasi",
              icons: Icon(
                Icons.info_outline_rounded,
                color: GetTheme().themeColor,
              ),
              subtitle:
                  "Beberapa Meditasi Berdasarkan Suasana Hatimu Saat Ini"),
        ),
        Padding(
          padding: EdgeInsets.only(left: paddingScreen, top: paddingScreen),
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: paddingScreen),
                  width: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: GetTheme().backgroundGrey(context),
                            borderRadius: BorderRadius.circular(10)),
                        width: 110,
                        height: 110,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Hilangkan Overthinkg",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "7 - 10 menit | seri",
                        style: TextStyle(
                            fontSize: 10,
                            color: GetTheme().unselectedWidget(context)),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget finishMeditasi({required context, required double paddingScreen}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingScreen),
      child: Column(
        children: [
          templateTitleHome(
              context: context,
              title: "Selesaikan Meditasi",
              icons: Icon(
                Icons.info_outline_rounded,
                color: GetTheme().themeColor,
              ),
              subtitle: "lanjutkan meditasi yang belum selesai"),
          ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return leadingWithArrow(
                context: context,
                colorWidget: Colors.blue,
                title: "Menerima diri",
                subtitle: "Durasi sesi 24 menit",
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: GetTheme().backgroundGrey(context),
                      borderRadius: BorderRadius.circular(100)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget article({required context, required double paddingScreen}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingScreen),
      child: Column(
        children: [
          templateTitleHome(
              context: context,
              title: "Artikel",
              icons: Icon(
                Icons.info_outline_rounded,
                color: GetTheme().themeColor,
              ),
              subtitle: "Artikel mengenai kesehatan mental"),
          const SizedBox(
            height: 2,
          )
        ],
      ),
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

Widget templateFeelIcons(
    {required String caption,
    required Color bgColor,
    required String svgIconsName}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
          child: SvgPicture.asset(svgAssetsLocation + svgIconsName),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(caption)
    ],
  );
}

Widget templateTitleHome(
    {required String title,
    required String subtitle,
    required Icon icons,
    required context}) {
  return ListTile(
    leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: GetTheme().backgroundGrey(context),
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child: icons),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(fontSize: 11),
    ),
  );
}
