// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/file_fromated.dart';
import 'package:zenmind/Main/Authentication/auth_services.dart';
import 'package:zenmind/Main/Authentication/login_menu.dart';
import 'package:zenmind/Main/UserMain/Account/EditAccount/profile_edit.dart';
import 'package:zenmind/Main/UserMain/Account/widget_profile.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/settings_all.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  UserModel users = UserModel();

  TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await AuthServices().getUsers(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        users = res.data as UserModel;
        isLoad = false;
      } else {}
    });
  }

  void logOut() async {
    var res = await AuthServices().logOut(token: tokenLocalUsers);
    if (res.error == null) {
      authPreferences.setToken("");
      authPreferences.setId(0);

      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(child: const LoginUI(), type: PageTransitionType.fade),
          (route) => false);
    } else {}
  }

  final picker = ImagePicker();
  File? imageFile;

  void setValuePickImgProfile({required final result}) async {
    Navigator.pop(context);
    if (result != null) {
      setState(() {
        imageFile = File(result.path);
        isLoad = true;
      });
    }

    var resUploadImg = await AuthServices().uploadImgProfile(
        token: tokenLocalUsers,
        img: convertFileToBase64(imageFile).toString(),
        filename: result.path.split('/').last);

    if (resUploadImg.error == null) {
      setState(() {
        getData();
        isLoad = false;
      });
    } else {}
  }

  void pickImageProfile() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: 130,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text("Gallery"),
                onTap: () async {
                  final result =
                      await picker.getImage(source: ImageSource.gallery);
                  if (result != null) {
                    setValuePickImgProfile(result: result);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () async {
                  final result =
                      await picker.getImage(source: ImageSource.camera);
                  if (result != null) {
                    setValuePickImgProfile(result: result);
                  }
                },
              )
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
                  children: [
                    ProfileWidget().cardDrawer(
                        title: 'Logout',
                        onPressed: () {
                          logOut();
                        },
                        background: Colors.red,
                        contentColors: Colors.white,
                        icon: Icons.logout)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
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
                          userdata: users,
                          context: context,
                          tapPhotosProfile: () {
                            pickImageProfile();
                          },
                          onTapSetting: () {
                            scaffoldKey.currentState!.openEndDrawer();
                          },
                          onTapEditProfile: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                  child: const ProfileEdit(),
                                  type: PageTransitionType.fade),
                            );
                            setState(() {
                              isLoad = true;
                              getData();
                            });
                          },
                        ),
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
                                  userdata: users,
                                  context: context,
                                  email: emailController),
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
