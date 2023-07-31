import 'package:flutter/material.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';

class TodaysSchedule extends StatefulWidget {
  const TodaysSchedule({Key? key}) : super(key: key);

  @override
  State<TodaysSchedule> createState() => _TodaysScheduleState();
}

class _TodaysScheduleState extends State<TodaysSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_circle_left_rounded,
              size: 30,
              color: Color(0xFFFF4DCCC1),
            )),
        title: Text(
          'Today\'s schedule',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
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
                  'This is your schedules',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE6E6E6),
            ),
            width: 400,
            height: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 35,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Meet with Adam',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.close_rounded,
                      size: 35,
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
                      '• Estimated income: IDR 25,000.00',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '• Date December 2, 2023, 20:00',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet.',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Adam@gmail.com',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF4DCCC1),
                          ),
                          width: 165,
                          height: 55,
                          child: Text(
                            'Chat',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF1E2754),
                          ),
                          width: 165,
                          height: 55,
                          child: Text(
                            'Meet',
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
          ),
        ],
      ),
    );
  }
}
