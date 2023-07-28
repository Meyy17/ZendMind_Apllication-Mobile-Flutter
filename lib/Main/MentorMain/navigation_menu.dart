import 'package:flutter/material.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/listroom_screen.dart';
import 'package:zenmind/Main/MentorMain/Account/profile_mentor.dart';
import 'package:zenmind/Main/MentorMain/EarningHistory/earning_history.dart';
import 'package:zenmind/Main/MentorMain/MentoringHistory/mentoring_history.dart';
import 'package:zenmind/Main/MentorMain/ReviewAndRating/review_rating.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';
import 'package:zenmind/Main/UserMain/Article/article_menu.dart';
import 'package:zenmind/Main/UserMain/Consultation/consultation_menu.dart';
import 'package:zenmind/Main/UserMain/Home/home_menu.dart';
import 'package:zenmind/Main/UserMain/MoodTracker/trackmood_menu.dart';
import 'package:zenmind/settings_all.dart';

class NavigationMentor extends StatefulWidget {
  const NavigationMentor({super.key});

  @override
  State<NavigationMentor> createState() => _NavigationMentorState();
}

class _NavigationMentorState extends State<NavigationMentor> {
  int screenindex = 0;
  final screen = [
    const HomeMenuMentor(),
    const EarningHistory(),
    const ReviewRating(),
    const MentoringHistory(),
    const ProfileMentor()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListRoomUserScreen(),
              ));
        },
        child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: GetTheme().primaryColor(context),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
        ),
      ),
      body: screen[screenindex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Article"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_sharp), label: "Consultation"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart_rounded),
              label: "Mood Tracker"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        unselectedItemColor: GetTheme().accentCardColors(context),
        selectedItemColor: GetTheme().buttonColors,
        elevation: 0,
        currentIndex: screenindex,
        onTap: (value) {
          setState(() {
            screenindex = value;
          });
        },
      ),
    );
  }
}
