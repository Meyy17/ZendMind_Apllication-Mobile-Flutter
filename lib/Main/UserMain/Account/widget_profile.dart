import 'package:flutter/material.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/Widget/InputText.dart';
import 'package:zenmind/env.dart';
import 'package:zenmind/settings_all.dart';

class ProfileWidget {
  Widget cardDrawer(
      {required String title,
      required Function()? onPressed,
      required IconData icon,
      required Color contentColors,
      required Color background}) {
    return Card(
      color: background,
      child: ListTile(
        leading: Icon(
          icon,
          color: contentColors,
        ),
        title: Text(title, style: TextStyle(color: contentColors)),
        onTap: onPressed,
      ),
    );
  }

  Widget header(
      {required context,
      required Function() onTapSetting,
      required Function() tapPhotosProfile,
      required Function() onTapEditProfile,
      required UserModel userdata}) {
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: userdata.data!.imgProfileURL != null
                      ? Image.network(
                          Environment().zendmindBASEURL +
                              userdata.data!.imgProfileURL.toString(),
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: 115,
                  child: Center(
                    child: InkWell(
                      onTap: tapPhotosProfile,
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
                  Expanded(
                      child: Text(
                    userdata.data!.name ?? "Error",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: onTapSetting, child: const Icon(Icons.settings)),
                ],
              ),
              Text(
                "Joined at ${formatDateToSlash(date: userdata.data!.createdAt.toString())}",
                style: const TextStyle(
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
                    context: context,
                    text: "Edit Profile",
                    onPressed: onTapEditProfile),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget generalView(
      {required context,
      required TextEditingController email,
      required UserModel userdata}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleGeneralView(text: "Email"),
        const SizedBox(
          height: 10,
        ),
        inputStyleFillWithIcons(
            readOnly: true,
            context: context,
            hintText: userdata.data!.email ?? "",
            prefixIcons: const Icon(Icons.email),
            controller: email,
            validator: null),
        const Spacer(),
        titleGeneralView(text: "Name"),
        const SizedBox(
          height: 10,
        ),
        inputStyleFillWithIcons(
            readOnly: true,
            context: context,
            hintText: userdata.data!.name ?? "",
            prefixIcons: const Icon(Icons.email),
            controller: email,
            validator: null),
        const Spacer(),
        titleGeneralView(text: "Gender"),
        const SizedBox(
          height: 10,
        ),
        inputStyleFillWithIcons(
            readOnly: true,
            context: context,
            hintText: userdata.data!.gender ?? "",
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
          const Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
              Text(
                'Consultation completed',
                style: TextStyle(fontSize: 12),
              ),
              Text(
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
