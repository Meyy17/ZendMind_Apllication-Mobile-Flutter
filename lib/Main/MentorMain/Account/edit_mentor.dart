import 'package:flutter/material.dart';
import 'package:zenmind/Main/MentorMain/Account/profile_mentor.dart';

class EditMentor extends StatefulWidget {
  const EditMentor({Key? key}) : super(key: key);

  @override
  State<EditMentor> createState() => _EditMentorState();
}

class _EditMentorState extends State<EditMentor> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMentor(),));
                }, icon: Icon(
                  Icons.arrow_circle_left_rounded,
                  size: 30,
                  color: Color(0xFFFF4DCCC1),
                )),
                SizedBox(width: 20,),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 165),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE6E6E6),
                      ),
                      width: 130,
                      height: 130,
                      // child: Image.asset(''),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00CBC8),
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          )
                      ),
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 23,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFE6E6E6),
                  ),
                  width: double.infinity,
                  height: 65,
                  child: Row(
                    children: [
                      Icon(
                        Icons.mail,
                        size: 25,
                        color: Color(0xFF5B5B5B),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        'Andika@gmail.com',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5B5B5B),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFE6E6E6),
                  ),
                  width: double.infinity,
                  height: 65,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 25,
                        color: Color(0xFF5B5B5B),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        'Andika Setya Eka Natha',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5B5B5B),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFE6E6E6),
                  ),
                  width: double.infinity,
                  height: 65,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 25,
                        color: Color(0xFF5B5B5B),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        'Fill your username',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5B5B5B),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
