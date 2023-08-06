import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Func/money_formated.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';

import '../../../DB/auth_preference.dart';
import '../../../Func/Services/mentor_services.dart';
import '../../../Models/earning_model.dart';

class EarningHistory extends StatefulWidget {
  const EarningHistory({Key? key}) : super(key: key);

  @override
  State<EarningHistory> createState() => _EarningHistoryState();
}

class _EarningHistoryState extends State<EarningHistory> {
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;
  GetEarningModel listSch = GetEarningModel();

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await MentorServices().getEarning(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        listSch = res.data as GetEarningModel;

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
          'Earning Menu',
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
          : Column(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 29),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your earnings balance',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 29),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFE6E6E6),
                      ),
                      width: 400,
                      height: 70,
                      child: Text(
                        MoneyFormated.convertToIdrWithSymbol(
                            count: listSch.data!.earningCount, decimalDigit: 2),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 29),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your earnings history',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                      itemCount: listSch.data!.earningData!.length,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(left: 29, top: 20),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFE6E6E6),
                          ),
                          width: 400,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Meet, ${formatDateEnglish(listSch.data!.earningData![index].dateMentoring.toString())} - ${timeFormatToHAndM(listSch.data!.earningData![index].timeMentoring.toString())}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                MoneyFormated.convertToIdrWithSymbol(
                                    count:
                                        listSch.data!.earningData![index].fee,
                                    decimalDigit: 2),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
