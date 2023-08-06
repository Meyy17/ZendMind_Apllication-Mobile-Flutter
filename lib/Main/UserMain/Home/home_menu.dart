import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/article_services.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Func/Services/trackmood_service.dart';
import 'package:zenmind/Main/Authentication/auth_services.dart';
import 'package:zenmind/Main/UserMain/Home/widget_home.dart';
import 'package:zenmind/Models/articles_model.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/settings_all.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int hoursnow = 0;
  int countonGoing = 0;
  String greeting = "Hello";
  double paddingScreen = GetSizeScreen().paddingScreen;

  UserModel users = UserModel();
  ArticlesModel article = ArticlesModel();
  ListScheduleMentoring dataOngoing = ListScheduleMentoring();
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;
  String username = "User";

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getCurrentDate();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await AuthServices().getUsers(token: tokenLocalUsers);
    var resArticle = await getArticle();
    var resOnGoing =
        await ConsultationService().getAllBookOngoing(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        users = res.data as UserModel;
        article = resArticle.data as ArticlesModel;
        dataOngoing = resOnGoing.data as ListScheduleMentoring;
        username = users.data!.name.toString();
        countonGoing = dataOngoing.data!.length;
        isLoad = false;
      } else {}
    });
  }

  void cancelBook(int idbook) async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    var res = await ConsultationService().cancelBook(idBook: idbook);

    if (res.error == null) {
      // Navigator.pop(context);
      Navigator.pop(context);
      setState(() {
        getData();
      });
    } else {
      print(res.error);
    }
  }

  String formatDate(DateTime dateTime) {
    // Format tanggal ke dalam format yyyy-mm-dd
    return "${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}";
  }

  String _twoDigits(int n) {
    // Fungsi pembantu untuk mengonversi bilangan ke dua digit (tambahkan nol jika perlu)
    if (n >= 10) {
      return "$n";
    }
    return "0$n";
  }

  String formatTime(TimeOfDay timeOfDay) {
    // Format waktu ke dalam format hh:mm:00
    String hour = _twoDigits(timeOfDay.hour);
    String minute = _twoDigits(timeOfDay.minute);
    return "$hour:$minute:00";
  }

  getCurrentDate() {
    var date = DateTime.now();
    var dateParse = DateTime.parse(date.toString());
    var formattedhours = "${dateParse.hour}";

    hoursnow = int.parse(formattedhours);

    if (hoursnow >= 5 && hoursnow < 11) {
      greeting = "Good Morning";
    } else if (hoursnow >= 11 && hoursnow < 15) {
      greeting = "Good Afternoon";
    } else if (hoursnow >= 15 && hoursnow < 18) {
      greeting = "Good Afternoon";
    } else if (hoursnow >= 18 && hoursnow <= 24) {
      greeting = "Good Night";
    } else if (hoursnow >= 0 && hoursnow < 5) {
      greeting = "Good Night";
    } else {
      greeting = "Hola";
    }
  }

  void isiSurvey(mood) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
          child: Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Loading ...",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ))),
    );
    var resadd = await TrackMoodService()
        .addMood(token: tokenLocalUsers, date: DateTime.now(), mood: mood);
    if (resadd.error == null) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: resadd.data.toString(),
          contentType: ContentType.success,
        ),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: paddingScreen,
              ),
              HomeWidget().header(
                  username: username,
                  context: context,
                  greeting: greeting,
                  paddingScreen: paddingScreen),
              HomeWidget()
                  .action(context: context, paddingScreen: paddingScreen),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        isiSurvey('happy');
                      },
                      child: templateFeelIcons(
                          caption: 'Happy',
                          bgColor: const Color(0xffEF5DA8),
                          svgIconsName: 'FeelHappyIcons.svg'),
                    ),
                    InkWell(
                      onTap: () {
                        isiSurvey('normal');
                      },
                      child: templateFeelIcons(
                          caption: 'Normal',
                          bgColor: const Color(0xff00CE90),
                          svgIconsName: 'FeelNormalIcons.svg'),
                    ),
                    InkWell(
                      onTap: () {
                        isiSurvey('sad');
                      },
                      child: templateFeelIcons(
                          caption: 'Sad',
                          bgColor: const Color(0xff4DCCC1),
                          svgIconsName: 'FeelSadIcons.svg'),
                    ),
                    InkWell(
                      onTap: () {
                        isiSurvey('angry');
                      },
                      child: templateFeelIcons(
                          caption: 'Angry',
                          bgColor: const Color(0xffFF696B),
                          svgIconsName: 'FeelAngryIcons.svg'),
                    ),
                  ],
                ),
              ),
              HomeWidget().featMentalHealth(
                  context: context, paddingScreen: paddingScreen),
              HomeWidget().aboutMentalHealth(
                  context: context, paddingScreen: paddingScreen),
              SizedBox(
                height: paddingScreen,
              ),
              HomeWidget().recomendationMeditasi(
                  articledata: article,
                  context: context,
                  paddingScreen: paddingScreen,
                  isLoad: isLoad),
               HomeWidget().finishMeditasi(
                    ongoingdata: dataOngoing,
                    countOngoing: countonGoing,
                    isLoad: isLoad,
                    context: context,
                    paddingScreen: paddingScreen),
              
              // HomeWidget()
              //     .article(context: context, paddingScreen: paddingScreen)
            ],
          ),
        ),
      ),
    );
  }
}
