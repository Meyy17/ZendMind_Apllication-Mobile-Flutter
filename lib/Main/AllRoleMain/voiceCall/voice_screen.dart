import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallMenu extends StatefulWidget {
  const CallMenu({super.key});
  // final String id_SecondUser;

  @override
  State<CallMenu> createState() => _CallMenuState();
}

class _CallMenuState extends State<CallMenu> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 1277896723,
        appSign:
            "1092926c60a647f47128d853160d1102266b592f6ec40a6640fea30caefe78b7",
        userID: "2",
        userName: "ANAK Durhaka",
        callID: "223",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
