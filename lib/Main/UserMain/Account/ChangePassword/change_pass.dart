import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Account/ChangePassword/check_email.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                  Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_circle_left_rounded,
                    size: 35,
                    color: Color(0xFF4DCCC1),
                  ),
                ),
                SizedBox(width: 20,),
                Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Text(
              "Change password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Enter the email associated with your\naccount and we’ll send an email with\ninstruction to reset yourpassword.",
              style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: 17,
              ),
            ),
            SizedBox(height: 25,),
            Image.asset(
                "Assets/Picture/Svg/Twirl.png",
              width: 70,
              height: 70,
            ),
            SizedBox(height: 20,),
            Text(
              "Email address",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFEAEEEF),
              ),
              height: 70,
              width: 400,
              child: Row(
                children: [
                  Text(
                    "@",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFFB0AFAF),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Text(
                    "Enter your email",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFFB0AFAF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 200,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckEmail(),));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF4DCCC1),
                ),
                height: 70,
                width: 400,
                child: Text(
                  "Send intructions",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
