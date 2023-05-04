import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zenmind/Main/Authentication/login_menu.dart';
import 'package:zenmind/Main/UserMain/navigation_menu.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/Widget/IconsWidget.dart';
import 'package:zenmind/Widget/InputText.dart';
import 'package:zenmind/settings_all.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  // Variable
  final formKey = GlobalKey<FormState>();

  //Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: GetSizeScreen().paddingScreen),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                circleIconsWthBG(context: context, size: 105),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: GetTheme().themeColor),
                ),
                const Spacer(),
                form(formkey: formKey),
                SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Or",
                        style: TextStyle(
                            color: GetTheme().unselectedWidget(context)),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                googleLoginBtn(
                    context: context, onPressed: () {}, text: "Google"),
                const SizedBox(
                  height: 10,
                ),
                actionTextButton(
                    text: "Already have an account?",
                    btnTxt: "Login",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const LoginUI()));
                    }),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget form({required formkey}) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          inputStyleFillWithIcons(
              prefixIcons: const Icon(Icons.person),
              validator: (p0) =>
                  p0!.isEmpty ? 'Mohon masukkan nama lengkap anda' : null,
              context: context,
              hintText: 'Full Name',
              controller: nameController),
          const SizedBox(
            height: 20,
          ),
          inputStyleFillWithIcons(
              prefixIcons: const Icon(Icons.email),
              validator: (p0) =>
                  p0!.isEmpty ? 'Mohon masukkan email anda' : null,
              context: context,
              hintText: 'Email',
              controller: emailController),
          const SizedBox(
            height: 20,
          ),
          inputStyleFillWithIcons(
              prefixIcons: const Icon(Icons.lock),
              validator: (p0) => p0!.length < 6
                  ? 'Minimal panjang password adalah 6 karakter'
                  : null,
              context: context,
              hintText: 'Password',
              controller: passwordController),
          const SizedBox(
            height: 40,
          ),
          flatButtonPrimaryRounded(
              context: context,
              text: "Register",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Navigation(),
                      ),
                      (route) => false);
                }
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
