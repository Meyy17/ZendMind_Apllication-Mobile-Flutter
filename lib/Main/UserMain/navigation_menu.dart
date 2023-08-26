import 'package:flutter/material.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/listroom_screen.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';
import 'package:zenmind/Main/UserMain/Article/article_menu.dart';
import 'package:zenmind/Main/UserMain/Consultation/consultation_menu.dart';
import 'package:zenmind/Main/UserMain/Home/home_menu.dart';
import 'package:zenmind/Main/UserMain/MoodTracker/trackmood_menu.dart';
import 'package:zenmind/settings_all.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int screenindex = 0;
  final screen = [
    const HomeMenu(),
    const ArticleMenu(),
    const ConsultationMenu(),
    const MoodTrackerMenu(),
    const ProfileMenu(
      isMentor: false,
    )
    // Consumer(builder: (context, ThemeModel themeNotifier, child) {
    //   return Center(
    //     child: IconButton(
    //       onPressed: () {
    //         themeNotifier.isDark
    //             ? themeNotifier.isDark = false
    //             : themeNotifier.isDark = true;
    //       },
    //       icon: AnimatedSwitcher(
    //           duration: const Duration(seconds: 1),
    //           transitionBuilder: (child, anim) => RotationTransition(
    //                 turns: child.key == const ValueKey('icon1')
    //                     ? Tween<double>(begin: 1, end: 0.75).animate(anim)
    //                     : Tween<double>(begin: 0.75, end: 1).animate(anim),
    //                 child: FadeTransition(opacity: anim, child: child),
    //               ),
    //           child: themeNotifier.isDark
    //               ? Icon(
    //                   Icons.light_mode_outlined,
    //                   key: const ValueKey('icon1'),
    //                   color: GetTheme().unselectedWidget(context),
    //                 )
    //               : Icon(
    //                   Icons.dark_mode,
    //                   key: const ValueKey('icon2'),
    //                   color: GetTheme().unselectedWidget(context),
    //                 )),
    //     ),
    //   );
    // }),
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
