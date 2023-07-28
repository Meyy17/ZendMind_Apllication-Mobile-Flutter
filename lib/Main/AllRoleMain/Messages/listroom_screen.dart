import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/message_services.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Models/listchat_model.dart';

class ListRoomUserScreen extends StatefulWidget {
  const ListRoomUserScreen({Key? key}) : super(key: key);

  @override
  State<ListRoomUserScreen> createState() => _ListRoomUserScreenState();
}

class _ListRoomUserScreenState extends State<ListRoomUserScreen> {
  AuthPreferences authPreferences = AuthPreferences();
  ListChatModel listData = ListChatModel();

  String tokenLocalUsers = "";
  bool isLoad = true;

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await MessageServices().getListChat(token: tokenLocalUsers);

    setState(() {
      if (res.error == null) {
        listData = res.data as ListChatModel;
        isLoad = false;
      } else {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: listData.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var dataList = listData.data![index];
                return ListTile(
                    title: Text(dataList.secondUser!.name.toString()),
                    subtitle: Text(dataList.message!.message.toString()),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoom(
                                id_SecondUser:
                                    dataList.idSecondUser.toString()),
                          ));
                      setState(() {
                        isLoad = true;
                        getData();
                      });
                    });
              },
            ),
    );
  }
}