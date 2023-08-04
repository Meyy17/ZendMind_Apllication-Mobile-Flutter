import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/UserMain/Article/ArticleDetail/article_detail.dart';
import 'package:zenmind/Main/UserMain/Article/article_menu.dart';
import 'package:zenmind/Main/UserMain/Home/OngoingConsultation/ongoing_consultation.dart';
import 'package:zenmind/Main/UserMain/Home/Transaction/transaction_page.dart';
import 'package:zenmind/Main/UserMain/bubbleb_menu.dart';
import 'package:zenmind/Models/articles_model.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';
import 'package:zenmind/Widget/CustomLeading.dart';
import 'package:zenmind/env.dart';
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
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            const Text(
              "What do you feel today?",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: OngoingConsul(),
                            type: PageTransitionType.fade));
                  },
                  child: templateFeatList(
                      context: context,
                      title: "Consultation",
                      locationSvgAssets: "cons.png"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: TransactionPage(),
                            type: PageTransitionType.fade));
                  },
                  child: templateFeatList(
                      context: context,
                      title: "Transaction",
                      locationSvgAssets: "trans.png"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: BubbleBreathe(),
                            type: PageTransitionType.fade));
                  },
                  child: templateFeatList(
                      context: context,
                      title: "Bubble Breath",
                      locationSvgAssets: "bubbleb.png"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ArticleMenu(),
                            type: PageTransitionType.fade));
                  },
                  child: templateFeatList(
                      context: context,
                      title: "Article",
                      locationSvgAssets: "artic.png"),
                ),
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
                Image.asset(
                  '${svgAssetsLocation}framehome.png',
                  width: GetSizeScreen().width(context) * 0.4,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mental health?",
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

  Widget recomendationMeditasi(
      {context,
      required double paddingScreen,
      required bool isLoad,
      required ArticlesModel articledata}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingScreen),
          child: templateTitleHome(
              context: context,
              title: "Article",
              icons: Icon(
                Icons.info_outline_rounded,
                color: GetTheme().themeColor,
              ),
              subtitle:
                  "Beberapa Artikel Tentang Mental Health Yang Dapat Kamu Baca"),
        ),
        Padding(
          padding: EdgeInsets.only(left: paddingScreen, top: paddingScreen),
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: isLoad
                  ? 10
                  : articledata.data!.length > 10
                      ? 10
                      : articledata.data!.length,
              itemBuilder: (context, index) {
                return isLoad
                    ? Container(
                        margin: EdgeInsets.only(right: paddingScreen),
                        width: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.black,
                              highlightColor: Colors.grey[350]!,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: GetTheme().backgroundGrey(context),
                                    borderRadius: BorderRadius.circular(10)),
                                width: 110,
                                height: 110,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[350]!,
                              child: const Text(
                                "Title",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[350]!,
                              child: Text(
                                "Subtitle",
                                style: TextStyle(
                                    fontSize: 10,
                                    color:
                                        GetTheme().unselectedWidget(context)),
                              ),
                            )
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ArticleDetail(
                                      p: articledata.data![index]),
                                  type: PageTransitionType.fade));
                        },
                        child: Container(
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    articledata.data![index].bannerURL
                                        .toString(),
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey[200]!,
                                            highlightColor: Colors.grey[350]!,
                                            child: Image.asset(
                                              'Assets/Picture/Svg/error-image.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        'Assets/Picture/Svg/error-image.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                articledata.data![index].title.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                maxLines: 1,
                                articledata.data![index].subtitle.toString(),
                                style: TextStyle(
                                    fontSize: 10,
                                    color:
                                        GetTheme().unselectedWidget(context)),
                              )
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget finishMeditasi(
      {required context,
      required double paddingScreen,
      required bool isLoad,
      required ListScheduleMentoring ongoingdata}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingScreen),
      child: Column(
        children: [
          templateTitleHome(
              context: context,
              title: "On Going Consultation",
              icons: Icon(
                Icons.info_outline_rounded,
                color: GetTheme().themeColor,
              ),
              subtitle: "jadwal konsultasi kamu yang belum selesai"),
          ListView.separated(
            itemCount: isLoad
                ? 1
                : ongoingdata.data!.length > 5
                    ? 5
                    : ongoingdata.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return isLoad
                  ? Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.grey[350]!,
                      child: leadingWithArrow(
                        context: context,
                        colorWidget: Colors.blue,
                        title: "Mentor Name",
                        subtitle: "00-00-0000 at 00:00",
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: GetTheme().backgroundGrey(context),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                    )
                  : leadingWithArrow(
                      context: context,
                      colorWidget: Colors.blue,
                      title: "${ongoingdata.data![index].mentor!.user!.name}",
                      subtitle:
                          "${formatDateToId(date: ongoingdata.data![index].dateMentoring.toString())} at ${timeFormatToHAndM(ongoingdata.data![index].timeMentoring)}",
                      leading: ongoingdata
                                  .data![index].mentor!.user!.imgProfileURL !=
                              ""
                          ? Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: GetTheme().backgroundGrey(context),
                                  borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  Environment().zendmindBASEURL +
                                      ongoingdata.data![index].mentor!.user!
                                          .imgProfileURL
                                          .toString(),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: Shimmer.fromColors(
                                            baseColor: Colors.grey[200]!,
                                            highlightColor: Colors.grey[350]!,
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: GetTheme()
                                                      .backgroundGrey(context),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.black,
                                                size: 32,
                                              ),
                                            )),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: GetTheme()
                                              .backgroundGrey(context),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 32,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: GetTheme().backgroundGrey(context),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 32,
                              ),
                            ));
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
      Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color(0xffF3F6F6),
            borderRadius: BorderRadius.circular(25.3)),
        width: GetSizeScreen().width(context) * 0.2,
        height: GetSizeScreen().width(context) * 0.2,
        child: Image.asset(svgAssetsLocation + locationSvgAssets),
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
