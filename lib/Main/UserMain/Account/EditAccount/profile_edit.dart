// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Main/Authentication/auth_services.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/Widget/InputText.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  UserModel users = UserModel();
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await AuthServices().getUsers(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        users = res.data as UserModel;
        _emailController.text = users.data!.email ?? "";
        _nameController.text = users.data!.name ?? "";
        _usernameController.text = users.data!.gender ?? "";
        isLoad = false;
      } else {}
    });
  }

  void updateProfile() async {
    var resUpdate = await AuthServices()
        .updateDisplay(token: tokenLocalUsers, name: _nameController.text);
    if (resUpdate.error == null) {
      Navigator.pop(context);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_circle_left,
                          color: Color(0xff42CCC9),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFD9D9D9),
                            radius: 70,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: const CircleAvatar(
                                backgroundColor: Color(0xff42CCC9),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.white, // Border color
                                  width: 5, // Border width// Border style
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputStyleFillWithIcons(
                          readOnly: false,
                          context: context,
                          hintText: "Insert Email",
                          prefixIcons: const Icon(Icons.email),
                          controller: _emailController,
                          validator: (p0) =>
                              p0!.isEmpty ? 'Please insert your email' : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputStyleFillWithIcons(
                          readOnly: false,
                          context: context,
                          hintText: "Insert Name",
                          prefixIcons: const Icon(Icons.person),
                          controller: _nameController,
                          validator: (p0) =>
                              p0!.isEmpty ? 'Please insert your name' : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Gender",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isLoad = true;
                                updateProfile();
                              });
                            },
                            child: const Text(
                              'Save changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
