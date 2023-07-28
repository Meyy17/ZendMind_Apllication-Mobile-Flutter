import 'package:flutter/material.dart';
import 'package:zenmind/Main/Start/Onboarding/OnboardingTwo.dart';
import 'package:zenmind/Main/Start/start_menu.dart';

class OnboardingThree extends StatefulWidget {
  const OnboardingThree({Key? key}) : super(key: key);

  @override
  State<OnboardingThree> createState() => _OnboardingThreeState();
}

class _OnboardingThreeState extends State<OnboardingThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DCCC1),
      body: Column(
        children: [
          SizedBox(height: 40,),
          Center(child: Image.asset("Assets/Picture/Svg/OnboardingThree.png", height: 350, width: 350,)),
          SizedBox(height: 40,),
          Text(
            "ZenMind",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 30,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            height: 317,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 35,),
                Text(
                  "Lorem Ipsum",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 35,),
                Text(
                  textAlign: TextAlign.center,
                  "Lorem ipsum dolor sit amet, consectetur adipiscing\n elit. Donec rutrum eros eu fringilla euismod.",
                  style: TextStyle(
                    color: Color(0xFF5C5C5C),
                  ),
                ),
                SizedBox(height: 35,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StartedUI(),));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF369B92),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 50,
                    width: 150,
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingTwo(),));
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Prev",
                      style: TextStyle(
                        color: Color(0xFF1A8FE3),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}