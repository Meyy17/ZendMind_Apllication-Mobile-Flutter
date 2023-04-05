import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmind/Main/DB/SharedPereference.dart';
import 'package:zenmind/Main/Start/Started-UI.dart';
import 'Settings.dart';
import 'Main/DB/SharedPereference.dart';

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
              primarySwatch: getTheme().themeColor,
              brightness: Brightness.dark),
          theme: ThemeData(primarySwatch: getTheme().themeColor),
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
    //             primarySwatch: getTheme().themeColor,
    //             brightness: Brightness.dark),
    //         theme: ThemeData(primarySwatch: getTheme().themeColor),
    //         home: const StartedUI(),
    //       );
    //     });
  }
}
