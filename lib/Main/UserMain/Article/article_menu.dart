import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Article/widget_article.dart';

class ArticleMenu extends StatefulWidget {
  const ArticleMenu({super.key});

  @override
  State<ArticleMenu> createState() => _ArticleMenuState();
}

class _ArticleMenuState extends State<ArticleMenu> {
  int indexSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              ArticleWidget().listLastArticle()
            ],
          ),
        ),
      ),
    );
  }
}
