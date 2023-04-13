// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:zenmind/Settings.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/Widget/IconsWidget.dart';
import 'package:zenmind/Widget/InputText.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  //Controller
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                "Login",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: getTheme().themeColor),
              ),
              const Spacer(),
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
                  validator: (p0) =>
                      p0!.isEmpty ? 'Mohon masukkan email anda' : null,
                  context: context,
                  hintText: 'Password',
                  controller: emailController),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {}, child: const Text("Forgot Password?"))
                ],
              ),
              flatButtonPrimaryRounded(
                  context: context, text: "Login", onPressed: () {}),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Or",
                      style: TextStyle(
                          color: getTheme().unselectedWidget(context)),
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
              actionTextButton(text: "New to ZenMind?", btnTxt: "Register"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
