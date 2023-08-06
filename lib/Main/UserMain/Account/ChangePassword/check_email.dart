import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Account/ChangePassword/new_pass.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 60,),
            Image.asset(
                "Assets/Picture/Svg/Email.png",
              height: 150,
              width: 150,
            ),
            SizedBox(height: 30,),
            Text(
              "Check your email",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "We have sent a password recover",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF5C5C5C),
              ),
            ),
            Text(
              "instructions to your email.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF5C5C5C),
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewPassword(),));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF4DCCC1),
                ),
                height: 60,
                width: 200,
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Text(
              "Did not receive the email? Check your ",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF5C5C5C),
              ),
            ),
            Text(
              "spam filter.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF5C5C5C),
              ),
            ),
            SizedBox(height: 30,),
            Text(
              "Or",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF5C5C5C),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                print("Resend email");
              },
              child: Text(
                "Resend email",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF4DCCC1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
