import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';

class SuccessPassChange extends StatefulWidget {
  const SuccessPassChange({Key? key}) : super(key: key);

  @override
  State<SuccessPassChange> createState() => _SuccessPassChangeState();
}

class _SuccessPassChangeState extends State<SuccessPassChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120,),
            Image.asset(
                "Assets/Picture/Svg/CheckSuccess.png",
              height: 180,
              width: 180,
            ),
            SizedBox(height: 20,),
            Text(
              "Password has been",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Text(
              "changed",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Remember and don't lose your",
              style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: 15,
              ),
            ),
            Text(
              "password.",
              style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: 15,
              ),
            ),
            SizedBox(height: 200,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMenu(),));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF4DCCC1),
                ),
                height: 60,
                width: 400,
                child: Text(
                  "Done",
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
