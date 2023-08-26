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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 29),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your total earnings',
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
                              count: listSch.data!.earningAll, decimalDigit: 2),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 29),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'income received',
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
                              count: listSch.data!.earningRec, decimalDigit: 2),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 29),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'income not yet received',
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
                              count: listSch.data!.earningNow, decimalDigit: 2),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 29),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'your account number',
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
                        physics: NeverScrollableScrollPhysics(),
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: listSch.data!.rekening!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: EdgeInsets.only(left: 29),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFE6E6E6),
                              ),
                              width: 400,
                              height: 70,
                              child: ListTile(
                                trailing: InkWell(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                                title: Text(
                                  "${listSch.data!.rekening![index].type} - ${listSch.data!.rekening![index].norek}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF369B92),
                          ),
                          height: 50,
                          child: Text(
                            'Tambahkan Rekening',
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
                    height: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 29),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'your income receipt history',
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
                        physics: NeverScrollableScrollPhysics(),
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 20),
                        itemCount: listSch.data!.earningRecData!.length,
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
                                    'Earning , ${formatDateEnglish(listSch.data!.earningRecData![index].createdAt.toString())} - ${listSch.data!.earningRecData![index].type.toString()} (${listSch.data!.earningRecData![index].norek.toString()})',
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
                                      count: listSch
                                          .data!.earningRecData![index].total,
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
            ),
    );
  }
}
