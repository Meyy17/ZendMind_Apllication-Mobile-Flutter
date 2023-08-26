import 'package:flutter/material.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Main/UserMain/Consultation/widget_consultation.dart';
import 'package:zenmind/Models/listmentor_model.dart';
import 'package:zenmind/settings_all.dart';

class ConsultationMenu extends StatefulWidget {
  const ConsultationMenu({super.key});

  @override
  State<ConsultationMenu> createState() => _ConsultationMenuState();
}

class _ConsultationMenuState extends State<ConsultationMenu> {
  bool isLoad = true;
  ListMentorModel mentorList = ListMentorModel();

  void getData() async {
    var res = await ConsultationService().getFreeMentor();
    setState(() {
      if (res.error == null) {
        mentorList = res.data as ListMentorModel;
        isLoad = false;
      } else {}
    });
  }

  void setData(int tab) async {
    setState(() {
      isLoad = true;
    });
    var res = await ConsultationService().getFreeMentor();

    if (tab == 1) {
      res = await ConsultationService().getPaidMentor();
    }
    setState(() {
      if (res.error == null) {
        mentorList = res.data as ListMentorModel;
        isLoad = false;
      } else {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: GetSizeScreen().paddingScreen),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Choose your Consultant",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: GetTheme().backgroundGrey(context)),
                    child: TabBar(
                      onTap: (value) {
                        setData(value);
                      },
                      indicator: BoxDecoration(
                          color: GetTheme().primaryColor(context),
                          borderRadius: BorderRadius.circular(10)),
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          GetTheme().unselectedWidget(context),
                      tabs: const [
                        Tab(
                          text: 'Free',
                        ),
                        Tab(
                          text: 'Paid',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ConsultationWidget()
                        .recomendation(mentorList: mentorList, isLoad: isLoad),
                  )
                  // Column(
                  //   children: [
                  //     // ConsultationWidget()
                  //     //     .needHandleList(context: context),
                  //     // const SizedBox(
                  //     //   height: 20,
                  //     // ),

                  //   ],
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}
