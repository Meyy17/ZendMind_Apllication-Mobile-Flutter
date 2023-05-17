import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Article/ArticleDetail/article_detail.dart';
import 'package:zenmind/settings_all.dart';

class ArticleWidget {
  Widget header({
    required String? Function(int?, CarouselPageChangedReason?)?
        onChangeCarosuel,
    required int indexSlider,
  }) {
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
            children: const [
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
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            width: GetSizeScreen().width(context),
            decoration: BoxDecoration(
                color: GetTheme().backgroundGrey(context),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("By : "),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Article Title"),
                      Text("Sub Heading"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DotsIndicator(
          dotsCount: 3,
          position: indexSlider.toDouble(),
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

  Widget listLastArticle() {
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
              TextButton(onPressed: () {}, child: const Text("View all"))
            ],
          ),
          ListView.separated(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ArticleDetail())
                  );
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
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Mental Health",
                            style: TextStyle(fontSize: 10),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Lorem ipsum dolor sit amet.",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: GetTheme().backgroundGrey(context),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              const Text(
                                "Mc Kindey",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
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
