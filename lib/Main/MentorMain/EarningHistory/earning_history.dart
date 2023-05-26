import 'package:flutter/material.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';

class EarningHistory extends StatefulWidget {
  const EarningHistory({Key? key}) : super(key: key);

  @override
  State<EarningHistory> createState() => _EarningHistoryState();
}

class _EarningHistoryState extends State<EarningHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29).copyWith(top: 111),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMenuMentor(),));
                }, icon: Icon(
                  Icons.arrow_circle_left_rounded,
                  size: 30,
                  color: Color(0xFFFF4DCCC1),
                )),
                SizedBox(width: 20,),
                Text(
                  'All mentoring',
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
                  'Here are your earning balance and earning history',
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
                  'Your earnings balance',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15,),
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
                  'Rp. 100.000,00',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
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
                  'Your earnings history',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
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
                        'Meet, 2 December 2023 - 08:00 PM',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Rp. 20.000,00',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
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
                        'Meet, 1 December 2023 - 10:00 PM',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Rp. 20.000,00',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
