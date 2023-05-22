import 'package:flutter/material.dart';

class HomeMenuMentor extends StatefulWidget {
  const HomeMenuMentor({super.key});

  @override
  State<HomeMenuMentor> createState() => _HomeMenuMentorState();
}

class _HomeMenuMentorState extends State<HomeMenuMentor> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome Mentor"),
      ),
    );
  }
}
