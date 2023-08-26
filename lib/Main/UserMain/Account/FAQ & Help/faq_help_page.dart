import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';

class FaqHelpPage extends StatefulWidget {
  const FaqHelpPage({Key? key}) : super(key: key);

  @override
  State<FaqHelpPage> createState() => _FaqHelpPageState();
}

class _FaqHelpPageState extends State<FaqHelpPage> {
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
                  "FAQ",
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
              "FAQ & Help",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFEAEEEF),
              ),
              height: 75,
              width: 400,
              child: Text(
                "About this application",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFEAEEEF),
              ),
              height: 75,
              width: 400,
              child: Text(
                "What feature this app have?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFEAEEEF),
              ),
              height: 75,
              width: 400,
              child: Text(
                "How to pay on this application?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFEAEEEF),
              ),
              height: 75,
              width: 400,
              child: Text(
                "Why this application?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
