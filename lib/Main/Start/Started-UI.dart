import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

class StartedUI extends StatefulWidget {
  const StartedUI({super.key});

  @override
  State<StartedUI> createState() => _StartedUIState();
}

class _StartedUIState extends State<StartedUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/283597779/original/2fd75528e8568ffc7f07d37077b908bbbe7c671b/design-high-quality-mental-health-logo.jpg",
                  width: 105,
                  height: 105,
                ),
                Text("ZenMind"),
                Text("Let’s Find Zen in Your Mind With Us.")
              ],
            ),
          )),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(150)),
                color: Color(0xff426E92)),
            height: 250,
            child: Center(
                child: ActionSlider.standard(
              boxShadow: [
                BoxShadow(
                    color: Colors.transparent, blurRadius: 0, spreadRadius: 0)
              ],
              action: (controller) async {
                controller.loading();
                await Future.delayed(const Duration(seconds: 1));
                controller.success();
              },
              successIcon: Icon(Icons.check),
              toggleColor: Colors.white,
              icon: Icon(Icons.arrow_forward_ios_outlined),
              backgroundColor: Color(0xff42CCC9),
              child: Text("Get Started"),
            )),
          )
        ],
      ),
    );
  }
}
