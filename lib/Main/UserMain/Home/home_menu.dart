import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Home/widget_home.dart';
import 'package:zenmind/settings_all.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int hoursnow = 0;
  String greeting = "";
  double paddingScreen = GetSizeScreen().paddingScreen;

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

  @override
  void initState() {
    super.initState();
    getCurrentDate();
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
                  username: "Mey",
                  context: context,
                  greeting: greeting,
                  paddingScreen: paddingScreen),
              HomeWidget()
                  .action(context: context, paddingScreen: paddingScreen),
              HomeWidget().featMentalHealth(
                  context: context, paddingScreen: paddingScreen),
              HomeWidget().aboutMentalHealth(
                  context: context, paddingScreen: paddingScreen),
              SizedBox(
                height: paddingScreen,
              ),
              HomeWidget().recomendationMeditasi(
                  context: context, paddingScreen: paddingScreen),
              HomeWidget().finishMeditasi(
                  context: context, paddingScreen: paddingScreen),
              HomeWidget()
                  .article(context: context, paddingScreen: paddingScreen)
            ],
          ),
        ),
      ),
    );
  }
}
