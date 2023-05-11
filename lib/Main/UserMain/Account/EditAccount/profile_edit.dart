import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Account/profile_menu.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 20,horizontal: 24),
        child: Container(
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
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileMenu()),
                      );
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
                  Container(
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
                        onTap: (){
                          print("Kepencet cuyy");
                        },
                        child: Container(
                          child: CircleAvatar(
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
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10,),
                    inputStyleFillWithIcons(context: context, hintText: "Insert Email", prefixIcons: Icon(Icons.email), controller: _emailController, validator: (p0) => p0!.isEmpty ? 'Please insert your email' : null,),
                    SizedBox(height: 20,),
                    Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10,),
                    inputStyleFillWithIcons(context: context, hintText: "Insert Name", prefixIcons: Icon(Icons.person), controller: _nameController, validator: (p0) => p0!.isEmpty ? 'Please insert your name' : null,),
                    SizedBox(height: 20,),
                    Text(
                      "Username",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10,),
                    inputStyleFillWithIcons(context: context, hintText: "Insert Username", prefixIcons: Icon(Icons.person), controller: _usernameController, validator: (p0) => p0!.isEmpty ? 'Please insert your username' : null,),
                    SizedBox(height: 30,),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: (){},
                          child: Text(
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
      ),
    );
  }
}
