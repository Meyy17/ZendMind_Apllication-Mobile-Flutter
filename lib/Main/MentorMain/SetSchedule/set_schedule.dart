import 'package:flutter/material.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';

class SetSchedule extends StatefulWidget {
  const SetSchedule({Key? key}) : super(key: key);

  @override
  State<SetSchedule> createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {
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
                  color: Color(0xFF4DCCC1),
                )),
                SizedBox(width: 20,),
                Text(
                  'Schedule',
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
                padding: EdgeInsets.only(left: 29,),
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
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 35,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE6E6E6),
            ),
            width: 400,
            height: 200,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                            Icons.lock_outline,
                          size: 35,
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'Everyday',
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
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                      Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 17,),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 17,),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 17,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF1E2754)
                          ),
                          width: 30,
                          height: 100,
                          child: Icon(
                              Icons.add,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 35,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE6E6E6),
            ),
            width: 400,
            height: 200,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 35,
                        ),
                        SizedBox(width: 15,),
                        Text(
                          '29 February 2023',
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
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 17,),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 17,),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10).copyWith(left: 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF00CBC8)
                                    ),
                                    width: 80,
                                    height: 40,
                                    child: Text(
                                      '20:00',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 67),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF369B92)
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 17,),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF1E2754)
                          ),
                          width: 30,
                          height: 100,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
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
