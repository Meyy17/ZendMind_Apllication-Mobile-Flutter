import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zenmind/Main/Authentication/login_menu.dart';
import 'package:zenmind/Main/Authentication/verifymail_menu.dart';
import 'package:zenmind/Models/auth_model.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/Widget/IconsWidget.dart';
import 'package:zenmind/Widget/InputText.dart';
import 'package:zenmind/settings_all.dart';

import '../../Models/response_model.dart';
import 'auth_services.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  // Variable
  final formKey = GlobalKey<FormState>();
  ApiResponse responseLogin = ApiResponse();
  RegisterModel userDataFromRegister = RegisterModel();

  //Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void orderRegister() async {
    var res = await AuthServices().register(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);

    setState(() {
      responseLogin = res;
      if (responseLogin.error == null) {
        setState(() {
          userDataFromRegister = responseLogin.data as RegisterModel;

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyEmailMenu(
                  password: passwordController.text,
                  email: userDataFromRegister.data!.email ?? "",
                ),
              ),
              (route) => false);
        });
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: responseLogin.error.toString(),
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    });
  }

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
                  "Hai, Welcome to zendmind",
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
              readOnly: false,
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
              readOnly: false,
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
              readOnly: false,
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
                  orderRegister();
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
