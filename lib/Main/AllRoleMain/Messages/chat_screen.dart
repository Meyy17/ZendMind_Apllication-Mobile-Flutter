import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/message_services.dart';
import 'package:zenmind/Models/message_model.dart';
import 'package:zenmind/env.dart';
import 'package:zenmind/settings_all.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key, required this.id_SecondUser});
  final String id_SecondUser;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  IO.Socket? socket;
  String tokenLocalUsers = "";
  int idUser = 0;
  bool isLoad = true;
  messageContentModel message = messageContentModel();
  TextEditingController inputMsgCtrl = TextEditingController();
  String roomID = "";

  String msg = "tes";
  // bool isLoad = true;

  void postChat() async {
    var res = await MessageServices().createChat(
        id_SecondUser: widget.id_SecondUser,
        token: tokenLocalUsers,
        roomID: roomID,
        message: inputMsgCtrl.text);
    inputMsgCtrl.clear();
  }

  void getData() async {
    var res = await MessageServices()
        .getMessage(token: tokenLocalUsers, roomID: roomID);
    setState(() {
      if (res.error == null) {
        message = res.data as messageContentModel;
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
    if (idUser.toString().compareTo(widget.id_SecondUser) > 0) {
      roomID = "$idUser-${widget.id_SecondUser}";
    } else {
      roomID = "${widget.id_SecondUser}-$idUser";
    }
    connectSocket();
    getData();
  }

  void connectSocket() {
    socket = IO.io(Environment().zendmindBASEURL, <String, dynamic>{
      'transports': ['websocket'],
    });
    socket!.connect();

    socket!.on('chat-${roomID}', (data) {
      print("Data : " + data['message']);
      setState(() {
        getData();
      });
    });
  }

  @override
  void initState() {
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
          isLoad ? "Loading..." : 'User',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoad
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: message.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            message.data![index].message ?? "",
                            textAlign: message.data![index].userId == idUser
                                ? TextAlign.end
                                : TextAlign.start,
                          ));
                    },
                  ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: TextFormField(
                  controller: inputMsgCtrl,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      isDense: true,
                      hintText: "Pesan...",
                      suffixIcon: InkWell(
                        onTap: () async {
                          postChat();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: GetTheme().primaryColor(context)),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            )),
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
