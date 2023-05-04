import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Account/widget_profile.dart';
import 'package:zenmind/settings_all.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: SafeArea(
        child: SizedBox(
          width: GetSizeScreen().width(context) * 0.5,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)),
            child: Drawer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [ProfileWidget().cardDrawer()],
                ),
              ),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: GetSizeScreen().paddingScreen),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  ProfileWidget().header(
                      context: context,
                      onTapSetting: () {
                        scaffoldKey.currentState!.openEndDrawer();
                      }),
                  const SizedBox(
                    height: 40,
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
                          text: 'General',
                        ),
                        Tab(
                          text: 'History',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ProfileWidget().generalView(
                            context: context, email: emailController),
                        ProfileWidget().historyView(context: context)
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
