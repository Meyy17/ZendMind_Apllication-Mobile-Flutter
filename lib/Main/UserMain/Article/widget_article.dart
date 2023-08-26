import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/Main/UserMain/Article/ArticleDetail/article_detail.dart';
import 'package:zenmind/Models/articles_model.dart';
import 'package:zenmind/settings_all.dart';

class ArticleWidget {
  Widget header(
      {required String? Function(int?, CarouselPageChangedReason?)?
          onChangeCarosuel,
      required int indexSlider,
      required ArticlesModel article,
      required bool isLoad}) {
    CarouselController carouselController = CarouselController();
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: GetSizeScreen().paddingScreen),
          child: Row(
            children: [
              Text(
                "Recomendation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CarouselSlider.builder(
          carouselController: carouselController,
          options: CarouselOptions(
            aspectRatio: 16 / 6.5,
            onPageChanged: onChangeCarosuel,
            initialPage: indexSlider,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
          ),
          itemCount: 3,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) => isLoad
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[350]!,
                      child: Container(
                        width: GetSizeScreen().width(context),
                        decoration: BoxDecoration(
                          color: GetTheme().backgroundGrey(context),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'Assets/Picture/Svg/error-image.png',
                                    fit: BoxFit.cover,
                                    width: GetSizeScreen().width(context),
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        'Assets/Picture/Svg/error-image.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  Container(
                                    width: GetSizeScreen().width(context),
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: GetSizeScreen().width(context),
                      decoration: BoxDecoration(
                        color: GetTheme().backgroundGrey(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network(
                                  article.data![itemIndex].bannerURL.toString(),
                                  fit: BoxFit.cover,
                                  width: GetSizeScreen().width(context),
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
                                Container(
                                  width: GetSizeScreen().width(context),
                                  color: Colors.black54,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.data![itemIndex].title ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      article.data![itemIndex].subtitle ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
        const SizedBox(
          height: 10,
        ),
        DotsIndicator(
          dotsCount: 3,
          position: indexSlider.toInt(),
          decorator: DotsDecorator(
              activeColor: GetTheme().themeColor,
              size: const Size.square(9.0),
              activeSize: const Size(25.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        )
      ],
    );
  }

  Widget listLastArticle(
      {required ArticlesModel article, required bool isLoad}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GetSizeScreen().paddingScreen),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Lastest article",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ListView.separated(
            itemCount: isLoad ? 4 : article.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return isLoad
                  ? GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: GetTheme().cardColors(context),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[350]!,
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    color: GetTheme().backgroundGrey(context),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'Assets/Picture/Svg/error-image.png',
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
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[200]!,
                                    highlightColor: Colors.grey[350]!,
                                    child: Text(
                                      "Title",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[200]!,
                                    highlightColor: Colors.grey[350]!,
                                    child: Text(
                                      "Subtitle",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: GetTheme()
                                                .backgroundGrey(context),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[200]!,
                                        highlightColor: Colors.grey[350]!,
                                        child: const Text(
                                          "Author",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetail(
                                      p: article.data![index],
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: GetTheme().cardColors(context),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                  color: GetTheme().backgroundGrey(context),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article.data![index].bannerURL.toString(),
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
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.data![index].title ?? "",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    article.data![index].subtitle ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            color: GetTheme()
                                                .backgroundGrey(context),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      ),
                                      const Text(
                                        "Zendmind",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
