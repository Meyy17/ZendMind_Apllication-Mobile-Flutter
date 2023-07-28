import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Article/article_menu.dart';
import 'package:zenmind/settings_all.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key, required this.p}) : super(key: key);

  final String p;

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset('Assets/Picture/Svg/ArticleDetailFill.png'),
            ),
            Container(
              width: double.infinity,
              height: 570,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 300, left: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              width: 150,
              height: 40,
              child: const Text(
                'Mental',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 350, left: 24),
              child: const Text(
                'Taking care of your Mental Health is important.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 420, left: 24),
              child: Row(
                children: [
                  Text(
                    'Trending',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '•',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '6 Hours ago',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: GetSizeScreen().height(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 470),
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 36, left: 40, right: 40),
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Source Name',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.verified,
                              size: 30,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.p,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 24, left: 24),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
