import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/Main/UserMain/Article/article_menu.dart';
import 'package:zenmind/Models/articles_model.dart';
import 'package:zenmind/settings_all.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key, required this.p}) : super(key: key);

  final Data p;

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<String> _pages = [];

  @override
  void initState() {
    super.initState();

    _splitContentIntoPages();
  }

  // Fungsi untuk membagi konten ke dalam halaman-halaman
  void _splitContentIntoPages() {
    final content = widget.p.content.toString();
    final words = content.split(' ');

    var pageSize = 100;

    // Atur berapa banyak kata yang ingin ditampilkan dalam satu halaman

    for (var i = 0; i < words.length; i += pageSize) {
      final pageWords = words.skip(i).take(pageSize).toList();
      final pageContent = pageWords.join(' ');
      _pages.add(pageContent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_circle_left_rounded,
                size: 30,
                color: Color(0xFFFF4DCCC1),
              )),
          title: Text(
            widget.p.title.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                      print(_currentPage);
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 36, left: 40, right: 40),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Visibility(
                                  visible: _currentPage == 0,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: GetSizeScreen().width(context),
                                        height: GetSizeScreen().width(context) /
                                            2.5,
                                        decoration: BoxDecoration(
                                            color: GetTheme()
                                                .backgroundGrey(context),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            widget.p.bannerURL.toString(),
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[200]!,
                                                    highlightColor:
                                                        Colors.grey[350]!,
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
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        widget.p.title.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                _pages[index],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: _currentPage > 0,
                        child: IconButton(
                            onPressed: _currentPage > 0
                                ? () {
                                    if (_currentPage > 0) {
                                      _pageController.previousPage(
                                        duration: Duration(
                                            milliseconds:
                                                300), // Animasi transisi
                                        curve: Curves.easeInOut, // Efek animasi
                                      );
                                      setState(() {
                                        _currentPage = _currentPage - 1;
                                        print(_currentPage);
                                      });
                                    }
                                  }
                                : null,
                            icon: Icon(
                              Icons.arrow_circle_left_rounded,
                              size: 30,
                              color: Color(0xFFFF4DCCC1),
                            )),
                      ),
                      Text(
                        "${_currentPage + 1} / ${_pages.length}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Visibility(
                        visible: _currentPage < _pages.length - 1,
                        child: IconButton(
                            onPressed: _currentPage < _pages.length - 1
                                ? () {
                                    if (_currentPage < _pages.length - 1) {
                                      _pageController.nextPage(
                                        duration: Duration(
                                            milliseconds:
                                                300), // Animasi transisi
                                        curve: Curves.easeInOut, // Efek animasi
                                      );
                                      setState(() {
                                        _currentPage = _currentPage + 1;
                                        print(_currentPage);
                                      });
                                    }
                                  }
                                : null,
                            icon: Icon(
                              Icons.arrow_circle_right_rounded,
                              size: 30,
                              color: Color(0xFFFF4DCCC1),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));

    // ...Bagian lain dari tampilan Anda...
  }
}
