import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Home/home_menu.dart';

import '../../../../Widget/Button.dart';
import '../../../../settings_all.dart';
import '../../Consultation/BookConsultation/book_consultation.dart';

class OngoingConsul extends StatefulWidget {
  const OngoingConsul({Key? key}) : super(key: key);

  @override
  State<OngoingConsul> createState() => _OngoingConsulState();
}

class _OngoingConsulState extends State<OngoingConsul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                        Icons.arrow_circle_left_rounded,
                      color: Color(0xFF4DCCC1),
                      size: 35,
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMenu(),));
                    },
                  ),
                  SizedBox(width: 15,),
                  Text(
                      "Ongoing",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                // var dataMentor = mentorList.data![index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index % 2 != 0
                          ? const Color(0xffF5F5DA)
                          : const Color(0xffACD8FE)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: GetTheme().backgroundGrey(context)),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lugas Richtigo",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 15),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Specialist :\n Anxiety",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: GetTheme().unselectedWidget(context)),
                              ),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: GetTheme().unselectedWidget(context)))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF1E2754),
                                ),
                                height: 45,
                                width: 110,
                                child: const Center(
                                  child: Text(
                                    "Chat",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("Chat");
                              },
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF1E2754),
                                ),
                                height: 45,
                                width: 110,
                                child: const Center(
                                  child: Text(
                                    "Reschedule",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("Reschedule");
                              },
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFFF696B),
                                ),
                                height: 45,
                                width: 110,
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                print("Cancel");
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
