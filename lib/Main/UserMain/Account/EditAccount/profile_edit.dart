// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/file_fromated.dart';
import 'package:zenmind/Main/Authentication/auth_services.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/Widget/InputText.dart';
import 'package:zenmind/env.dart';
import 'package:zenmind/settings_all.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _base64ImgProfileController = TextEditingController();
  String _urlImgProfileController = "";
  final _fileNameImgProfileController = TextEditingController();

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
        _urlImgProfileController = Environment().zendmindBASEURL +
            users.data!.imgProfileURL.toString();
        isLoad = false;
      } else {}
    });
  }

  //UpdateProfileArea

  void updateProfile() async {
    var resUpdate = await AuthServices()
        .updateDisplay(token: tokenLocalUsers, name: _nameController.text);
    if (resUpdate.error == null) {
      if (_base64ImgProfileController.text != "") {
        var resUploadImg = await AuthServices().uploadImgProfile(
            token: tokenLocalUsers,
            img: _base64ImgProfileController.text,
            filename: _fileNameImgProfileController.text);

        if (resUploadImg.error == null) {
          Navigator.pop(context);
        } else {}
      } else {
        Navigator.pop(context);
      }
    } else {}
  }

  final picker = ImagePicker();
  File? imageFile;

  void setValuePickImgProfile({required final result}) {
    if (result != null) {
      setState(() {
        imageFile = File(result.path);
        _base64ImgProfileController.text =
            convertFileToBase64(imageFile).toString();
        _fileNameImgProfileController.text = result.path.split('/').last;
      });
    }
    Navigator.pop(context);
  }

  void pickImageProfile() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: 130,
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text("Gallery"),
                onTap: () async {
                  final result =
                      await picker.getImage(source: ImageSource.gallery);
                  if (result != null) {
                    setValuePickImgProfile(result: result);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () async {
                  final result =
                      await picker.getImage(source: ImageSource.camera);
                  if (result != null) {
                    setValuePickImgProfile(result: result);
                  }
                },
              )
            ],
          )),
    );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 175,
                        child: Stack(
                          children: [
                            Container(
                              width: 155,
                              height: 155,
                              decoration: BoxDecoration(
                                  color: GetTheme().backgroundGrey(context),
                                  borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: imageFile != null
                                    ? Image.file(
                                        imageFile!,
                                        fit: BoxFit.cover,
                                      )
                                    : _urlImgProfileController != ""
                                        ? Image.network(
                                            _urlImgProfileController,
                                            fit: BoxFit.cover,
                                          )
                                        : const Center(
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                          ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: SizedBox(
                                width: 155,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      pickImageProfile();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: GetTheme().cardColors(context),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: GetTheme()
                                                .primaryColor(context),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: const Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
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
                          inputVisibilty: false,
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
                          inputVisibilty: false,
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
                        // const Text(
                        //   "Gender",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.w600),
                        // ),
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
