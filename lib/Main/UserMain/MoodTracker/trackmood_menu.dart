import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/trackmood_service.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Main/UserMain/MoodTracker/widget_trackmenu.dart';
import 'package:zenmind/Models/trackmood_Model.dart';
import 'package:zenmind/settings_all.dart';

class MoodTrackerMenu extends StatefulWidget {
  const MoodTrackerMenu({super.key});

  @override
  State<MoodTrackerMenu> createState() => _MoodTrackerMenuState();
}

class _MoodTrackerMenuState extends State<MoodTrackerMenu> {
  DateTime selectedDate = DateTime.now();
  String tokenLocalUsers = "";
  MoodTrackerModel moodData = MoodTrackerModel();

  bool isLoad = true;

  void addOneDay() {
    setState(() {
      isLoad = true;
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
      getData();
    });
  }

  void kurangiOneDay() {
    setState(() {
      isLoad = true;
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
      getData();
    });
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await TrackMoodService()
        .getByUserAndMonth(date: selectedDate, token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        moodData = res.data as MoodTrackerModel;
        isLoad = false;
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: GetSizeScreen().paddingScreen),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: const [
                  Text(
                    "Your mood tracker",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        kurangiOneDay();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  InkWell(
                    onTap: () async {
                      final picked = await showMonthYearPicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2100));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                          getData();
                        });
                      }
                    },
                    child: Text(
                      formatDateToIdOnlyMonthAndYears(
                          date: selectedDate.toString()),
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        addOneDay();
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TrackerMoodWidget().chartMood(
                      context: context, moodData: moodData, isload: isLoad),
                  TrackerMoodWidget().listMood(
                      context: context, moodData: moodData, isLoad: isLoad)
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
