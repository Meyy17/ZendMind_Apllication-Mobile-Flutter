// ignore_for_file: deprecated_member_use, must_be_immutable, unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Main/Authentication/auth_services.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';
import 'package:zenmind/Main/MentorMain/navigation_menu.dart';
import 'package:zenmind/Main/Start/Onboarding/OnboardingOne.dart';
import 'package:zenmind/Main/Start/start_menu.dart';
import 'package:zenmind/Main/UserMain/navigation_menu.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/settings_all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Func/Controller/Firebase/notification_controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  NotificationController.initialize();

  runApp(const MyApp());
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";

  UserModel users = UserModel();

  bool isLoad = true;

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await AuthServices().getUsers(token: tokenLocalUsers);

    if (res.error == null) {
      setState(() {
        users = res.data as UserModel;
        isLoad = false;
      });
    } else if (res.error == "Invalid Token") {
      await authPreferences.setToken("");
      await authPreferences.setId(0);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        tokenLocalUsers =
            sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
        isLoad = false;
      });
    } else {
      print(res.error);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          print("WOII ANJRRR ");
          // if (message.data['email'] != null) {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => ChatUI(
          //       email: message.data['email'],
          //     ),
          //   ),
          // );
          // }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          print(message.data);
          NotificationController.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          // print("yo : " + message.data["_id"]);
          // print(message.notification!.title);
          // print(message.notification!.body);
          // print("message.data22 ${message.data['_id']}");
        }
      },
    );
    setTokenDevice();
  }

  void setTokenDevice() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    print("Token : " + token.toString());
  }

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
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            MonthYearPickerLocalizations.delegate,
          ],
          darkTheme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData(brightness: Brightness.dark).textTheme,
              ),
              primarySwatch: GetTheme().themeColor,
              brightness: Brightness.dark),
          theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData(brightness: Brightness.light).textTheme,
              ),
              primarySwatch: GetTheme().themeColor),
          home: isLoad
              ? Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : tokenLocalUsers != ""
                  ? users.data!.role.toString() == "mentor"
                      ? const NavigationMentor()
                      : const Navigation()
                  : const OnboardingOne(),
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
