import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:zenmind/Main/Authentication/login_menu.dart';

//Package
import 'package:action_slider/action_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenmind/Widget/IconsWidget.dart';
import 'package:zenmind/settings_all.dart';

class StartedUI extends StatelessWidget {
  const StartedUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        themeNotifier.isDark
                            ? themeNotifier.isDark = false
                            : themeNotifier.isDark = true;
                      },
                      icon: AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          transitionBuilder: (child, anim) =>
                              RotationTransition(
                                turns: child.key == const ValueKey('icon1')
                                    ? Tween<double>(begin: 1, end: 0.75)
                                        .animate(anim)
                                    : Tween<double>(begin: 0.75, end: 1)
                                        .animate(anim),
                                child:
                                    FadeTransition(opacity: anim, child: child),
                              ),
                          child: themeNotifier.isDark
                              ? Icon(
                                  Icons.light_mode_outlined,
                                  key: const ValueKey('icon1'),
                                  color: GetTheme().unselectedWidget(context),
                                )
                              : Icon(
                                  Icons.dark_mode,
                                  key: const ValueKey('icon2'),
                                  color: GetTheme().unselectedWidget(context),
                                )),
                    ),
                  ],
                ),
                Expanded(
                    child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      circleIconsWthBG(context: context, size: 121),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "ZenMind",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: GetTheme().themeColor),
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Stack(children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        "${svgAssetsLocation}SplashCircleAssets.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      padding: EdgeInsets.symmetric(
                          horizontal: GetSizeScreen().paddingScreen),
                      child: Center(
                          child: ActionSlider.standard(
                        backgroundBorderRadius: BorderRadius.circular(10.0),
                        foregroundBorderRadius: BorderRadius.circular(10),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 0,
                              spreadRadius: 0)
                        ],
                        action: (controller) {
                          controller.loading();
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const LoginUI()),
                              (route) => false);
                        },

                        loadingIcon: const SizedBox(
                            width: 55,
                            child: Center(
                                child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2.0, color: Colors.white),
                            ))),
                        toggleColor: GetTheme().thirdColor,
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                        ),
                        backgroundColor: GetTheme().buttonColors,
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 15),
                        ),
                      )),
                    )
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
