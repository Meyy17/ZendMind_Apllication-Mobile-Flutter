import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/Func/Services/mentor_services.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/listroom_screen.dart';
import 'package:zenmind/Main/MentorMain/Account/profile_mentor.dart';
import 'package:zenmind/Main/MentorMain/AllMentoring/all_mentoring.dart';
import 'package:zenmind/Main/MentorMain/EarningHistory/earning_history.dart';
import 'package:zenmind/Main/MentorMain/MentoringHistory/mentoring_history.dart';
import 'package:zenmind/Main/MentorMain/ReviewAndRating/review_rating.dart';
import 'package:zenmind/Main/MentorMain/SetSchedule/set_schedule.dart';
import 'package:zenmind/Main/MentorMain/TodaysSchedule/todays_schedule.dart';
import 'package:zenmind/Models/profilementor_model.dart';
import '../../DB/auth_preference.dart';
import '../../Func/money_formated.dart';
import '../../Models/listsmentoring_model.dart';
import '../Authentication/auth_services.dart';
import '../Authentication/login_menu.dart';

class HomeMenuMentor extends StatefulWidget {
  const HomeMenuMentor({super.key});

  @override
  State<HomeMenuMentor> createState() => _HomeMenuMentorState();
}

class _HomeMenuMentorState extends State<HomeMenuMentor> {
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;

  MentorProfileModel users = MentorProfileModel();
  ListScheduleMentoring allSch = ListScheduleMentoring();
  ListScheduleMentoring todaySch = ListScheduleMentoring();

  int formattoDay(String dateR) {
    DateTime date = DateTime.parse(dateR);
    int day = date.day;
    return day;
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await MentorServices().getProfileMentor(token: tokenLocalUsers);
    var resAllSch =
        await MentorServices().getAllScheduleMentoring(token: tokenLocalUsers);
    var resTodaySch = await MentorServices()
        .getTodayScheduleMentoring(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        users = res.data as MentorProfileModel;
        allSch = resAllSch.data as ListScheduleMentoring;
        todaySch = resTodaySch.data as ListScheduleMentoring;

        isLoad = false;
      } else {}
    });
  }

  void logOut() async {
    var res = await AuthServices().logOut(token: tokenLocalUsers);
    if (res.error == null) {
      authPreferences.setToken("");
      authPreferences.setId(0);

      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(child: const LoginUI(), type: PageTransitionType.fade),
          (route) => false);
    } else {
      print(res.error);
      authPreferences.setToken("");
      authPreferences.setId(0);
    }
  }

  String formatMonthName(String dateR) {
    DateTime date = DateTime.parse(dateR);
    int month = date.month;

    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "-";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 29, bottom: 50)
                      .copyWith(top: 33),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileMentor(),
                                  ));
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(0xFF000000),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good morning, ${users.data!.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: Color(0xFF42CCC9),
                            ),
                            width: 52,
                            height: 52,
                            child: Icon(
                              Icons.notifications_none_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Your earning balance',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFE6E6E6),
                            ),
                            height: 60,
                            width: 390,
                            child: Text(
                              MoneyFormated.convertToIdrWithSymbol(
                                  count: int.parse(users
                                      .data!.mentorProfile!.incomeNow
                                      .toString()),
                                  decimalDigit: 2),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF369B92),
                                  ),
                                  height: 50,
                                  width: 170,
                                  child: Text(
                                    '${MoneyFormated.convertToIdrWithSymbol(count: int.parse(users.data!.mentorProfile!.fee.toString()), decimalDigit: 0)} / patient',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                              "Handling Fee",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            content: TextField(
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Enter your custom fee here"),
                                            ),
                                            actions: [
                                              GestureDetector(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                          horizontal: 24.0)
                                                      .copyWith(bottom: 16),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF1E2754),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    width: 300,
                                                    height: 50,
                                                    child: Text(
                                                      "Set Fee",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF1E2754),
                                  ),
                                  height: 50,
                                  width: 140,
                                  child: Text(
                                    'Custom fee',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Your session schedule:',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 90,
                            child: ListView.separated(
                              itemCount: users
                                  .data!.mentorProfile!.scheduleMentor!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 15,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                var scheduleData = users.data!.mentorProfile!
                                    .scheduleMentor![index];
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFE6E6E6),
                                  ),
                                  height: 80,
                                  width: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        formattoDay(
                                                scheduleData.date.toString())
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        formatMonthName(
                                                scheduleData.date.toString())
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SetSchedule(),
                                      ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF369B92),
                                  ),
                                  height: 50,
                                  width: 150,
                                  child: Text(
                                    'Set schedule',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your schedule today',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TodaysSchedule(),
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Text(
                                        'See all...',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 45),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFFE6E6E6),
                                      ),
                                      width: 170,
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15)),
                                              color: Color(0xFFACD8FE),
                                            ),
                                            width: 21,
                                            height: 80,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Adam',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                '12 March 2022',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                '18:00',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.add,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFFE6E6E6),
                                      ),
                                      width: 170,
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15)),
                                              color: Color(0xFFFF92CA),
                                            ),
                                            width: 21,
                                            height: 80,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Vierra',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                '12 March 2022',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                '18:00',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.add,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'All schedule',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllMentoring(),
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Text(
                                        'See all...',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 45),
                                child: ListView.separated(
                                  itemCount: 5,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFFE6E6E6),
                                      ),
                                      width: 170,
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15)),
                                              color: Color(0xFFACD8FE),
                                            ),
                                            width: 21,
                                            height: 80,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Mich',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                '12 March 2022',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                '18:00',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.add,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            logOut();
                          },
                          child: Text('Logout')),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
