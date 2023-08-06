import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/message_services.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Models/listchat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../env.dart';

class ListRoomUserScreen extends StatefulWidget {
  const ListRoomUserScreen({Key? key}) : super(key: key);

  @override
  State<ListRoomUserScreen> createState() => _ListRoomUserScreenState();
}

class _ListRoomUserScreenState extends State<ListRoomUserScreen> {
  AuthPreferences authPreferences = AuthPreferences();
  ListChatModel listData = ListChatModel();
  IO.Socket? socket;

  String tokenLocalUsers = "";
  int idUser = 0;
  bool isLoad = true;

  void connectSocket() {
    socket = IO.io(Environment().zendmindBASEURL, <String, dynamic>{
      'transports': ['websocket'],
    });
    socket!.connect();

    socket!.on('room-${idUser}', (data) {
      print("Data : " + data['message']);
      setState(() {
        getData();
      });
    });
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
      idUser = sharedPreferences.getInt(AuthPreferences.idKey) ?? 0;
    });

    var res = await MessageServices().getListChat(token: tokenLocalUsers);

    setState(() {
      if (res.error == null) {
        listData = res.data as ListChatModel;
        connectSocket();
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_circle_left_rounded,
              size: 30,
              color: Color(0xFFFF4DCCC1),
            )),
        title: Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
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
