import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Consultation/widget_consultation.dart';
import 'package:zenmind/settings_all.dart';

class ConsultationMenu extends StatefulWidget {
  const ConsultationMenu({super.key});

  @override
  State<ConsultationMenu> createState() => _ConsultationMenuState();
}

class _ConsultationMenuState extends State<ConsultationMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: SafeArea(
            child: SingleChildScrollView(
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
                    ConsultationWidget().needHandleList(context: context),
                    const SizedBox(
                      height: 20,
                    ),
                    ConsultationWidget().recomendation()
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
