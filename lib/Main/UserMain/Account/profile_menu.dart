// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Func/file_fromated.dart';
import 'package:zenmind/Main/Authentication/auth_services.dart';
import 'package:zenmind/Main/Authentication/login_menu.dart';
import 'package:zenmind/Main/UserMain/Account/ChangePassword/change_pass.dart';
import 'package:zenmind/Main/UserMain/Account/EditAccount/profile_edit.dart';
import 'package:zenmind/Main/UserMain/Account/FAQ%20&%20Help/faq_help_page.dart';
import 'package:zenmind/Main/UserMain/Account/widget_profile.dart';
import 'package:zenmind/Models/bookhistory_model.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/settings_all.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key, required this.isMentor});
  final bool isMentor;

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  UserModel users = UserModel();
  BookingHistoryModel freehistory = BookingHistoryModel();
  BookingHistoryModel paidhistory = BookingHistoryModel();

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
    var freeBookres = await ConsultationService()
        .getHistoryBook(token: tokenLocalUsers, status: "Free");
    var paidBookres = await ConsultationService()
        .getHistoryBook(token: tokenLocalUsers, status: "Paid");
    setState(() {
      if (res.error == null) {
        users = res.data as UserModel;
        freehistory = freeBookres.data as BookingHistoryModel;
        paidhistory = paidBookres.data as BookingHistoryModel;
        isLoad = false;
      } else {}
    });
  }

  void logOut() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure to Logout?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No")),
          TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Center(
                      child: Container(
                          height: 70,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CupertinoActivityIndicator(),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Loading ...",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ))),
                );
                var res = await AuthServices().logOut(token: tokenLocalUsers);
                if (res.error == null) {
                  authPreferences.setToken("");
                  authPreferences.setId(0);
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const LoginUI(),
                          type: PageTransitionType.fade),
                      (route) => false);
                } else {}
              },
              child: Text("Yes"))
        ],
      ),
    );
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ProfileWidget().cardDrawer(
                            title: 'Edit Profile',
                            onPressed: () async {
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
                            background: Colors.white70,
                            contentColors: Colors.black,
                            icon: Icons.edit),
                        ProfileWidget().cardDrawer(
                            title: 'FAQ & Help',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FaqHelpPage(),
                                  ));
                            },
                            background: Colors.white70,
                            contentColors: Colors.black,
                            icon: Icons.edit),
                        // ProfileWidget().cardDrawer(
                        //     title: 'Change Pass',
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => ChangePass(),
                        //           ));
                        //     },
                        //     background: Colors.white70,
                        //     contentColors: Colors.black,
                        //     icon: Icons.edit)
                      ],
                    ),
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
      body: widget.isMentor
          ? SafeArea(
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
                      isLoad: isLoad,
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
                    Expanded(
                      child: ProfileWidget().generalView(
                          userdata: users,
                          isLoad: isLoad,
                          context: context,
                          email: emailController),
                    ),
                  ],
                ),
              ),
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
                          isLoad: isLoad,
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
                                  isLoad: isLoad,
                                  context: context,
                                  email: emailController),
                              ProfileWidget().historyView(
                                  bookpaidData: paidhistory,
                                  isLoad: isLoad,
                                  context: context,
                                  bookfreeData: freehistory)
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
