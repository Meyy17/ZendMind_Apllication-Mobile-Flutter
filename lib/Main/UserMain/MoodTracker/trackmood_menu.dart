import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/MoodTracker/widget_trackmenu.dart';
import 'package:zenmind/settings_all.dart';

class MoodTrackerMenu extends StatefulWidget {
  const MoodTrackerMenu({super.key});

  @override
  State<MoodTrackerMenu> createState() => _MoodTrackerMenuState();
}

class _MoodTrackerMenuState extends State<MoodTrackerMenu> {
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
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  const Text(
                    "Agustus 2023",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios_rounded))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TrackerMoodWidget().chartMood(context: context),
              TrackerMoodWidget().listMood(context: context)
            ],
          ),
        ),
      ),
    ));
  }
}
