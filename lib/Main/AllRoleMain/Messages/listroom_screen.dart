import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/message_services.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Models/listchat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../env.dart';
import '../../../settings_all.dart';

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
    var res = await MessageServices().getListChat(token: tokenLocalUsers);

    setState(() {
      if (res.error == null) {
        listData = res.data as ListChatModel;
        isLoad = false;
      } else {}
    });
  }

  void start() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
      idUser = sharedPreferences.getInt(AuthPreferences.idKey) ?? 0;
    });
    connectSocket();
    getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  void dispose() {
    socket!.disconnect();
    socket!.destroy();
    super.dispose();
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
                    leading: dataList.secondUser!.imgProfileURL != ""
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: GetTheme().backgroundGrey(context),
                                borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                Environment().zendmindBASEURL +
                                    dataList.secondUser!.imgProfileURL
                                        .toString(),
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: Shimmer.fromColors(
                                          baseColor: Colors.grey[200]!,
                                          highlightColor: Colors.grey[350]!,
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: GetTheme()
                                                    .backgroundGrey(context),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.black,
                                              size: 32,
                                            ),
                                          )),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color:
                                            GetTheme().backgroundGrey(context),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                      size: 32,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: GetTheme().backgroundGrey(context),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 32,
                            ),
                          ),
                    title: Text(dataList.secondUser!.name.toString()),
                    subtitle: Text(dataList.message!.message.toString()),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoom(
                                username: dataList.secondUser!.name.toString(),
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
