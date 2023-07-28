import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Main/Authentication/auth_services.dart';
import 'package:zenmind/Main/Authentication/register_menu.dart';
import 'package:zenmind/Main/Authentication/verifymail_menu.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';
import 'package:zenmind/Main/UserMain/navigation_menu.dart';
import 'package:zenmind/Models/auth_model.dart';
import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/Widget/IconsWidget.dart';
import 'package:zenmind/Widget/InputText.dart';
import 'package:zenmind/settings_all.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  // Variable
  final formKey = GlobalKey<FormState>();
  ApiResponse responseLogin = ApiResponse();
  LoginModel userDataFromLogin = LoginModel();

  AuthPreferences authLocalDB = AuthPreferences();

  //Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoad = false;
  bool passwordInputVisibilty = true;

  void orderLogin() async {
    var res = await AuthServices()
        .login(email: emailController.text, password: passwordController.text);

    setState(() {
      responseLogin = res;
      if (responseLogin.error == null) {
        setState(() {
          userDataFromLogin = responseLogin.data as LoginModel;

          authLocalDB.setToken(userDataFromLogin.data!.user!.token ?? "");
          authLocalDB.setId(userDataFromLogin.data!.user!.id ?? 0);

          if (authLocalDB.getToken() != null) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: userDataFromLogin.data!.user!.role.toString() ==
                            "mentor"
                        ? const HomeMenuMentor()
                        : const Navigation()),
                (route) => false);
          }
        });
      } else if (res.error == "Verify email") {
        setState(() {
          isLoad = false;
        });
        showCupertinoDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Please Verify Ur Email"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: VerifyEmailMenu(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                            type: PageTransitionType.fade));
                  },
                  child: const Text("Yes"))
            ],
          ),
        );
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
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GetSizeScreen().paddingScreen),
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
                        "Welcome back to zendmind",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: GetTheme().themeColor),
                      ),
                      const Spacer(),
                      form(formkey: formKey),
                      // SizedBox(
                      //     width: double.infinity,
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         "Or",
                      //         style: TextStyle(
                      //             color: GetTheme().unselectedWidget(context)),
                      //       ),
                      //     )),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // googleLoginBtn(
                      //     context: context, onPressed: () {}, text: "Google"),
                      const SizedBox(
                        height: 10,
                      ),
                      actionTextButton(
                          text: "New to ZenMind?",
                          btnTxt: "Register",
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const RegisterUI()));
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
              inputVisibilty: false,
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
              inputVisibilty: passwordInputVisibilty,
              readOnly: false,
              prefixIcons: const Icon(Icons.lock),
              validator: (p0) => p0!.length < 6
                  ? 'Minimal panjang password adalah 6 karakter'
                  : null,
              context: context,
              hintText: 'Password',
              controller: passwordController),
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
              context: context,
              text: "Login",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    isLoad = true;
                  });
                  orderLogin();
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
