import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Image.network(
                  "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/283597779/original/2fd75528e8568ffc7f07d37077b908bbbe7c671b/design-high-quality-mental-health-logo.jpg")
            ],
          ))
        ],
      ),
    );
  }
}
