// ignore_for_file: prefer_const_constructors, file_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//DevFile
import 'package:zenmind/Settings.dart';

//Package
import 'package:action_slider/action_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                          duration: Duration(seconds: 1),
                          transitionBuilder: (child, anim) =>
                              RotationTransition(
                                turns: child.key == ValueKey('icon1')
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
                                  color: getTheme().textColors(context),
                                )
                              : Icon(
                                  Icons.dark_mode,
                                  key: const ValueKey('icon2'),
                                  color: getTheme().textColors(context),
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
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffD4FFFB),
                            borderRadius: BorderRadius.circular(100)),
                        child: SvgPicture.asset(
                          svgAssetsLocation + "Icons-1.svg",
                          width: 105,
                          height: 105,
                        ),
                      ),
                      Text("ZenMind"),
                      Text("Let’s Find Zen in Your Mind With Us.")
                    ],
                  ),
                )),
                Container(
                  width: double.infinity,
                  height: 311,
                  child: Stack(children: [
                    SizedBox(
                      height: 311,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        svgAssetsLocation + "SplashCircleAssets.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                          child: ActionSlider.standard(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 0,
                              spreadRadius: 0)
                        ],
                        action: (controller) async {
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 1));
                          controller.success();
                        },
                        successIcon: Icon(Icons.check),
                        toggleColor: getTheme().cardColors(context),
                        icon: Icon(Icons.arrow_forward_ios_outlined),
                        backgroundColor: Color(0xff42CCC9),
                        child: Text("Get Started"),
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
