import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';

import '../../../DB/auth_preference.dart';
import '../../../Func/Services/mentor_services.dart';
import '../../../Models/getrate_model.dart';

class ReviewRating extends StatefulWidget {
  const ReviewRating({Key? key}) : super(key: key);

  @override
  State<ReviewRating> createState() => _ReviewRatingState();
}

class _ReviewRatingState extends State<ReviewRating> {
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;
  GetRateModel listSch = GetRateModel();

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await MentorServices().getReview(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        listSch = res.data as GetRateModel;

        isLoad = false;
      } else {}
    });
  }

  double rateFormat(double rate) {
    if (rate == 0) {
      rate = 0.0;
    } else if (rate == 1) {
      rate = 1.0;
    } else if (rate == 2) {
      rate = 2.0;
    } else if (rate == 3) {
      rate = 3.0;
    } else if (rate == 4) {
      rate = 4.0;
    } else if (rate == 5) {
      rate = 5.0;
    } else {
      rate = rate;
    }

    return rate;
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
          'Review And Rating',
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
                          'Your rating:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 29),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 35,
                              color: Colors.orangeAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${rateFormat(double.parse(listSch.data!.averageRate.toString()))} stars',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
                              'Your review',
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
                            itemCount: listSch.data!.review!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xFFE6E6E6),
                                  ),
                                  width: 400,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            listSch
                                                .data!.review![index].user!.name
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            formatDateEnglish(listSch
                                                .data!.review![index].createdAt
                                                .toString()),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Color(0xFF616161),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        listSch.data!.review![index].message
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0xFF616161),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemSize: 25,
                                            rating: rateFormat(double.parse(
                                                listSch
                                                    .data!.review![index].rate
                                                    .toString())),
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star_rounded,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(rateFormat(double.parse(listSch
                                                  .data!.review![index].rate
                                                  .toString()))
                                              .toString())
                                        ],
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
