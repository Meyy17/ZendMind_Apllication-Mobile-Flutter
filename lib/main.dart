// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmind/Main/Start/start_menu.dart';
import 'package:zenmind/settings_all.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {
        return MaterialApp(
          title: 'ZenMind',
          debugShowCheckedModeBanner: false,
          themeMode: themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData(brightness: Brightness.dark).textTheme,
              ),
              primarySwatch: GetTheme().themeColor,
              buttonColor: GetTheme().buttonColors,
              brightness: Brightness.dark),
          theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData(brightness: Brightness.light).textTheme,
              ),
              buttonColor: GetTheme().buttonColors,
              primarySwatch: GetTheme().themeColor),
          home: const StartedUI(),
        );
      }),
    );
    // return ValueListenableBuilder(
    //     // valueListenable: getInformation(),
    //     builder: (_, ThemeMode currentMode, __) {
    //       return MaterialApp(
    //         title: 'ZenMind',
    //         debugShowCheckedModeBanner: false,
    //         themeMode: currentMode,
    //         darkTheme: ThemeData(
    //             primarySwatch: GetTheme().themeColor,
    //             brightness: Brightness.dark),
    //         theme: ThemeData(primarySwatch: GetTheme().themeColor),
    //         home: const StartedUI(),
    //       );
    //     });
  }
}
