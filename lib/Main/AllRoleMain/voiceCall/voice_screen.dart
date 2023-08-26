import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../DB/auth_preference.dart';

class CallMenu extends StatefulWidget {
  const CallMenu(
      {super.key, required this.id_SecondUser, required this.username});
  final String id_SecondUser;
  final String username;

  @override
  State<CallMenu> createState() => _CallMenuState();
}

class _CallMenuState extends State<CallMenu> {
  int id_user = 0;
  String roomID = "";
  void start() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id_user = sharedPreferences.getInt(AuthPreferences.idKey) ?? 0;
    });
    if (id_user.toString().compareTo(widget.id_SecondUser) > 0) {
      roomID = "$id_user-${widget.id_SecondUser}";
    } else {
      roomID = "${widget.id_SecondUser}-$id_user";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 1277896723,
        appSign:
            "1092926c60a647f47128d853160d1102266b592f6ec40a6640fea30caefe78b7",
        userID: id_user.toString(),
        userName: widget.username,
        callID: roomID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
