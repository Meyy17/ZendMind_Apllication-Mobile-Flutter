import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Home/home_menu.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                children: [
                  GestureDetector(
                    child: const Icon(
                        Icons.arrow_circle_left_rounded,
                      color: Color(0xFF4DCCC1),
                      size: 35,
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMenu(),));
                    },
                  ),
                  const SizedBox(width: 15,),
                  const Text(
                    "Transaction",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEAEEEF),
              ),
              height: 120,
              width: 400,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      print("Pending");
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            "Assets/Picture/Svg/Pending.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32,),
                  GestureDetector(
                    onTap: (){
                      print("Completed");
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "Assets/Picture/Svg/Completed.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32,),
                  GestureDetector(
                    onTap: (){
                      print("Cancelled");
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "Assets/Picture/Svg/Cancelled.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "Cancelled",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32,),
                  GestureDetector(
                    onTap: (){
                      print("Failed");
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "Assets/Picture/Svg/Failed.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "Failed",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEAEEEF),
              ),
              height: 90,
              width: 400,
              child: const Row(
                children: [
                  Text(
                    "August • 01 • 2023",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Icon(
                      Icons.keyboard_arrow_down_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEAEEEF),
              ),
              height: 185,
              width: 400,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                          "Assets/Picture/Svg/DoctorProfile.png",
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(width: 15,),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lugas Richtigo",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Specialties: Anxiety",
                            style: TextStyle(
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "August • 01 • 2023",
                            style: TextStyle(
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Rp. 100.000",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Consultation",
                            style: TextStyle(
                              color: Color(0xFF3DBA76),
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          print("Pay now");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF4DCCC1),
                          ),
                          height: 50,
                          width: 170,
                          child: const Text(
                              "Pay now",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          print("Cancel");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFFF696B),
                          ),
                          height: 50,
                          width: 170,
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEAEEEF),
              ),
              height: 185,
              width: 400,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "Assets/Picture/Svg/DoctorProfile.png",
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(width: 15,),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lugas Richtigo",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Specialties: Anxiety",
                            style: TextStyle(
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "August • 01 • 2023",
                            style: TextStyle(
                              color: Color(0xFF5C5C5C),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Rp. 100.000",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                              "Consultation",
                              style: TextStyle(
                                color: Color(0xFF3DBA76),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          print("Pay now");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF4DCCC1),
                          ),
                          height: 50,
                          width: 170,
                          child: const Text(
                            "Pay now",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          print("Cancel");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFFF696B),
                          ),
                          height: 50,
                          width: 170,
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
