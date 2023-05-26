import 'package:flutter/material.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';

class ReviewRating extends StatefulWidget {
  const ReviewRating({Key? key}) : super(key: key);

  @override
  State<ReviewRating> createState() => _ReviewRatingState();
}

class _ReviewRatingState extends State<ReviewRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29).copyWith(top: 111),
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMenuMentor(),));
                      }, icon: Icon(
                      Icons.arrow_circle_left_rounded,
                    size: 30,
                    color: Color(0xFFFF4DCCC1),
                  )),
                  SizedBox(width: 20,),
                  Text(
                    'Review and Rating',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 29),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Good morning, doctors',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 29),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Here are the review from patients that you handled',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35,),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 29),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your total rating:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.only(left: 29),
                  child: Row(
                    children: [
                      Icon(
                          Icons.star_rounded,
                        size: 35,
                        color: Colors.orangeAccent,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        '4.0 stars',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35,),
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
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFE6E6E6),
                      ),
                      width: 400,
                      height: 205,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: 20,),
                              Text(
                                'Adam',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '17 February 2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color(0xFF616161),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'The mentoring is really cool, its really easy to understand, I really recommend this doctorfor you guys!',
                            style: TextStyle(
                              color: Color(0xFF616161),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Icon(
                                  Icons.star_rounded,
                                size: 30,
                                color: Colors.orange,
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ],
                ),
                SizedBox(height: 20,),
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
                    SizedBox(height: 15,),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFE6E6E6),
                        ),
                        width: 400,
                        height: 205,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  'Adam',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '17 February 2023',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF616161),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Text(
                              'The mentoring is really cool, its really easy to understand, I really recommend this doctorfor you guys!',
                              style: TextStyle(
                                color: Color(0xFF616161),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ],
                ),
                SizedBox(height: 35,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
