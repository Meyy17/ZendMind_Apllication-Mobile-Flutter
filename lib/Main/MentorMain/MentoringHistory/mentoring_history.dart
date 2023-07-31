import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/mentor_services.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Func/money_formated.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';
import 'package:zenmind/settings_all.dart';

class MentoringHistory extends StatefulWidget {
  const MentoringHistory({Key? key}) : super(key: key);

  @override
  State<MentoringHistory> createState() => _MentoringHistoryState();
}

class _MentoringHistoryState extends State<MentoringHistory> {
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;
  ListScheduleMentoring listSch = ListScheduleMentoring();

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await MentorServices()
        .getHistoryScheduleMentoring(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        listSch = res.data as ListScheduleMentoring;

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
      appBar: AppBar(
        title: Text(
          'History mentoring',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 29,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hai, doctors',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 29),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'This is your mentoring history',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listSch.data!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      var data = listSch.data![index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFE6E6E6),
                        ),
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Meet with ${data.user!.name}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• income: ${MoneyFormated.convertToIdrWithSymbol(count: data.fee, decimalDigit: 2)}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '• Date : ${formatDateEnglish(data.dateMentoring.toString())}, ${timeFormatToHAndM(data.timeMentoring.toString())}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // Text(
                                //   'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet.',
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 15,
                                // ),
                                // Text(
                                //   'Adam@gmail.com',
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: data.status.toString() ==
                                                  "Finished"
                                              ? Color(0xFF4DCCC1)
                                              : Colors.red),
                                      width: 350,
                                      height: 45,
                                      child: Text(
                                        data.status.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
