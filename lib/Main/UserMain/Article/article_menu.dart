import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/Main/UserMain/Article/widget_article.dart';
import 'package:zenmind/Models/articles_model.dart';

import '../../../Func/Services/article_services.dart';

class ArticleMenu extends StatefulWidget {
  const ArticleMenu({super.key});

  @override
  State<ArticleMenu> createState() => _ArticleMenuState();
}

class _ArticleMenuState extends State<ArticleMenu> {
  int indexSlider = 0;
  ArticlesModel article = ArticlesModel();
  bool isLoad = true;

  void getData() async {
    var resArticle = await getArticle();
    setState(() {
      if (resArticle.error == null) {
        article = resArticle.data as ArticlesModel;
        isLoad = false;
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ArticleWidget().header(
                        onChangeCarosuel: (p0, p1) {
                          setState(() {
                            indexSlider = p0!;
                          });
                          return null;
                        },
                        indexSlider: indexSlider),
                    ArticleWidget().listLastArticle(article: article)
                  ],
                ),
              ),
            ),
    );
  }
}
