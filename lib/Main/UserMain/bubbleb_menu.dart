import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:zenmind/Widget/Button.dart';
import 'dart:async';
import 'dart:math';
import 'package:zenmind/settings_all.dart';

class BubbleBreathe extends StatefulWidget {
  @override
  _BubbleBreatheState createState() => _BubbleBreatheState();
}

class _BubbleBreatheState extends State<BubbleBreathe> {
  bool _isBreathing = false;
  bool _isBreathingNext = false;
  String instructionText = "Klik untuk mulai";
  int breathDuration = 120;
  int durationToDown = 4;
  int durationToUp = 6;
  bool _isExhaling = false;
  final player = AudioPlayer();

  Timer? _countdownTimer;
  int _remainingSeconds = 0;

  void _startBreathing() async {
    await player.play(UrlSource(
        'https://6e92-180-253-65-58.ngrok-free.app/audio/awowowowk.mp3'));
    // player.setPlayerMode(PlayerMode.mediaPlayer);

    setState(() {
      _isBreathing = true;
      instructionText = "Tarik nafas";
      _remainingSeconds = breathDuration;

      _startCountdownTimer();
    });
  }

  void _stopBreathing() async {
    await player.pause();
    setState(() {
      _isBreathingNext = true;
      instructionText = "Klik untuk mulai";

      _countdownTimer?.cancel();
    });
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        }

        bool isTimeToExhale = _remainingSeconds % durationToUp == 0;

        if (_remainingSeconds == 0) {
          _countdownTimer?.cancel();
          setState(() {
            instructionText = "Lepaskan nafas";
            Future.delayed(Duration(seconds: 2), _startBreathing);
          });
        } else {
          if (isTimeToExhale) {
            _countdownTimer!.cancel();
            Future.delayed(
                Duration(seconds: durationToDown), _startCountdownTimer);
          }
          instructionText = isTimeToExhale ? "Lepaskan nafas" : "Tarik nafas";
        }
      });
    });
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr.$secondsStr';
  }

  void onOpened() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GetTheme().themeColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
              Spacer(),
              Text(
                formatDuration(_remainingSeconds),
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: CircularProgressIndicator(
                        value: _remainingSeconds == 0
                            ? 0
                            : 1 - _remainingSeconds / breathDuration,
                        backgroundColor: Colors.white70,
                        color: Colors.blue,
                        strokeWidth: 5,
                      ),
                    ),
                    GestureDetector(
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              instructionText,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (!_isBreathing) {
                          _startBreathing();
                        } else {
                          if (_isBreathingNext) {
                            await player.resume();
                            _startCountdownTimer();
                            setState(() {
                              _isBreathingNext = false;
                            });
                          } else {
                            _stopBreathing();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 59,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (!_isBreathing) {
                          _startBreathing();
                        } else {
                          if (_isBreathingNext) {
                            await player.resume();
                            _startCountdownTimer();
                            setState(() {
                              _isBreathingNext = false;
                            });
                          } else {
                            _stopBreathing();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff153B50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 0),
                      child: Text(
                        _isBreathing
                            ? _isBreathingNext
                                ? "Lanjutkan"
                                : "Berhenti"
                            : "Mulai",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800),
                      ))),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
