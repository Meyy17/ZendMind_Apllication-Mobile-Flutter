// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Main/UserMain/navigation_menu.dart';
import 'package:zenmind/Models/auth_model.dart';

import '../../Widget/Button.dart';
import '../../Widget/IconsWidget.dart';
import '../../settings_all.dart';
import 'auth_services.dart';

class VerifyEmailMenu extends StatefulWidget {
  const VerifyEmailMenu(
      {super.key, required this.email, required this.password});
  final String email;
  final String password;

  @override
  State<VerifyEmailMenu> createState() => _VerifyEmailMenuState();
}

class _VerifyEmailMenuState extends State<VerifyEmailMenu> {
  AuthPreferences authLocalDB = AuthPreferences();
  LoginModel userDataFromLogin = LoginModel();
  bool isLoad = false;
  void sendVerifyEmail() async {
    var res = await AuthServices().sendVerifyEmail(email: widget.email);
    if (res.error == null) {
      setState(() {
        isLoad = false;
      });
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: res.data.toString(),
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      setState(() {
        isLoad = false;
      });
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: res.error.toString(),
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Timer? timer;

  checkEmailVerified() async {
    var res = await AuthServices().checkVerifyEmail(email: widget.email);

    if (res.error == null) {
      var resLogin = await AuthServices()
          .login(email: widget.email, password: widget.password);

      if (resLogin.error == null) {
        setState(() {
          userDataFromLogin = resLogin.data as LoginModel;

          authLocalDB.setToken(userDataFromLogin.data!.user!.token ?? "");
          authLocalDB.setId(userDataFromLogin.data!.user!.id ?? 0);

          if (authLocalDB.getToken() != null) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const Navigation()),
                (route) => false);
            timer?.cancel();
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  circleIconsWthBG(context: context, size: 105),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome back to zendmind",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: GetTheme().themeColor),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: flatButtonPrimaryRounded(
                        context: context,
                        text: "Send Verify Email",
                        onPressed: () {
                          setState(() {
                            isLoad = true;
                          });
                          sendVerifyEmail();
                        }),
                  ),
                  const Spacer(),
                ],
              ),
            )),
    );
  }
}
