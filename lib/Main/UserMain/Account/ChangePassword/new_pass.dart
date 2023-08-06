import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Account/ChangePassword/sucess_pass_change.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_circle_left_rounded,
                    size: 35,
                    color: Color(0xFF4DCCC1),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Create new password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your new password must be different\nfrom previous used passwords.",
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFF5C5C5C),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "New password",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFEAEEEF),
              ),
              height: 70,
              width: 400,
              child: Row(
                children: [
                  Icon(
                    Icons.lock,
                    size: 25,
                    color: Color(0xFFB0AFAF),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFFB0AFAF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Must be at least 8 characters.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFFB0AFAF),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Confirm new password",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFEAEEEF),
              ),
              height: 70,
              width: 400,
              child: Row(
                children: [
                  Icon(
                    Icons.lock,
                    size: 25,
                    color: Color(0xFFB0AFAF),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFFB0AFAF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Both password must match.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFFB0AFAF),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessPassChange(),
                    ));
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
                  "Reset password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
