import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Account/EditAccount/profile_edit.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/Widget/InputText.dart';
import 'package:zenmind/settings_all.dart';

class ProfileWidget {
  Widget cardDrawer() {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.light_mode_outlined),
        title: Text("Change Theme"),
      ),
    );
  }

  Widget header({required context, required Function() onTapSetting}) {
    return Row(
      children: [
        SizedBox(
          height: 130,
          child: Stack(
            children: [
              Container(
                width: 115,
                height: 115,
                decoration: BoxDecoration(
                    color: GetTheme().backgroundGrey(context),
                    borderRadius: BorderRadius.circular(100)),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: 115,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: GetTheme().cardColors(context),
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: GetTheme().primaryColor(context),
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Andika Setya Eka Natha",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: onTapSetting, child: const Icon(Icons.settings)),
                ],
              ),
              const Text(
                "Joined at dd/mm/yyyy",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 120,
                height: 40,
                child: flatButtonPrimaryRounded(
                    context: context, text: "Edit Profile", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit()),
                    );
                }),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget generalView({required context, required TextEditingController email}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleGeneralView(text: "Email"),
        const SizedBox(
          height: 10,
        ),
        inputStyleFillWithIcons(
            context: context,
            hintText: "Andika@gmail.com",
            prefixIcons: const Icon(Icons.email),
            controller: email,
            validator: null),
        const Spacer(),
        titleGeneralView(text: "Name"),
        const SizedBox(
          height: 10,
        ),
        inputStyleFillWithIcons(
            context: context,
            hintText: "Andika Setya Natha",
            prefixIcons: const Icon(Icons.email),
            controller: email,
            validator: null),
        const Spacer(),
        titleGeneralView(text: "Username"),
        const SizedBox(
          height: 10,
        ),
        inputStyleFillWithIcons(
            context: context,
            hintText: "Andika",
            prefixIcons: const Icon(Icons.email),
            controller: email,
            validator: null),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }

  Widget historyView({required context}) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36,
            width: GetSizeScreen().width(context) * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: GetTheme().backgroundGrey(context)),
            child: TabBar(
              indicator: BoxDecoration(
                  color: GetTheme().primaryColor(context),
                  borderRadius: BorderRadius.circular(10)),
              labelColor: Colors.white,
              unselectedLabelColor: GetTheme().unselectedWidget(context),
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
            height: 5,
          ),
          Expanded(
              child: TabBarView(
            children: [
              ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cardHistory(context: context);
                },
              ),
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cardHistory(context: context);
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}

Widget cardHistory({required context}) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            width: 45,
            height: 50,
            color: GetTheme().backgroundGrey(context),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      "Lugas Richtigo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Text(
                    "Free",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Text(
                'Consultation completed',
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                "13 Feb 15:30",
                style: TextStyle(
                  fontSize: 10,
                ),
              )
            ],
          )),
        ],
      ),
      const Divider()
    ],
  );
}

Widget titleGeneralView({required String text}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  );
}
