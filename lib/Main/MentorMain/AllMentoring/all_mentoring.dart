import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Func/Services/mentor_services.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Func/money_formated.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';

class AllMentoring extends StatefulWidget {
  const AllMentoring({Key? key}) : super(key: key);

  @override
  State<AllMentoring> createState() => _AllMentoringState();
}

class _AllMentoringState extends State<AllMentoring> {
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;
  ListScheduleMentoring listSch = ListScheduleMentoring();

  String formatDate(DateTime dateTime) {
    // Format tanggal ke dalam format yyyy-mm-dd
    return "${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}";
  }

  String _twoDigits(int n) {
    // Fungsi pembantu untuk mengonversi bilangan ke dua digit (tambahkan nol jika perlu)
    if (n >= 10) {
      return "$n";
    }
    return "0$n";
  }

  String formatTime(TimeOfDay timeOfDay) {
    // Format waktu ke dalam format hh:mm:00
    String hour = _twoDigits(timeOfDay.hour);
    String minute = _twoDigits(timeOfDay.minute);
    return "$hour:$minute:00";
  }

  void reschedule(String dateNow, String idmentoring) async {
    DateTime _selectedDate = DateTime.now();
    String date = "";
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _selectedDate,
      lastDate: DateTime(2101),
    );

    setState(() {
      _selectedDate = picked!;
      date = formatDate(_selectedDate);
      print(date);
    });

    TimeOfDay _selectedTime = TimeOfDay.now();
    String time = "";

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime:
          _selectedTime, // Waktu awal yang ditampilkan pada time picker
    );

    setState(() {
      _selectedTime = pickedTime!;
      time = formatTime(_selectedTime);
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No")),
            TextButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        Center(child: CircularProgressIndicator()),
                  );
                  var res = await ConsultationService().reschedule(
                      idmentoring: idmentoring, newDate: date, newTime: time);

                  if (res.error == null) {
                    // Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {
                      getData();
                    });
                  } else {
                    print(res.error);
                  }
                },
                child: Text("Yes"))
          ],
          content: Text(
              "Are you sure to send request to Reschedule From $dateNow to ${formatDateEnglish(date.toString())}, ${timeFormatToHAndM(time.toString())}")),
    );
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res =
        await MentorServices().getAllScheduleMentoring(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        listSch = res.data as ListScheduleMentoring;

        isLoad = false;
      } else {}
    });
  }

  void cancelBook(int idbook) async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    var res = await ConsultationService().cancelBook(idBook: idbook);

    if (res.error == null) {
      Navigator.pop(context);
      Navigator.pop(context);
      setState(() {
        getData();
      });
    } else {
      print(res.error);
    }
  }

  @override
  void initState() {
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
          'All schedule',
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
          : listSch.data!.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.only(
                      //         left: 29,
                      //       ),
                      //       alignment: Alignment.centerLeft,
                      //       child: Text(
                      //         'Good morning, doctors',
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       padding: EdgeInsets.only(left: 29),
                      //       alignment: Alignment.centerLeft,
                      //       child: Text(
                      //         'This is all schedule you have',
                      //         style: TextStyle(fontSize: 15),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listSch.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 12,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var data = listSch.data![index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFE6E6E6),
                            ),
                            width: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Meet with ${data.user!.name}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatRoom(
                                                  id_SecondUser:
                                                      data.user!.id.toString()),
                                            ));
                                      },
                                      child: Icon(
                                        Icons.chat,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '• Estimated income: ${MoneyFormated.convertToIdrWithSymbol(count: data.fee, decimalDigit: 2)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '• Date : ${formatDateEnglish(data.dateMentoring.toString())}, ${timeFormatToHAndM(data.timeMentoring.toString())}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Text(
                                    //   'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet.',
                                    //   style: TextStyle(
                                    //     fontSize: 15,
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    // Text(
                                    //   'Adam@gmail.com',
                                    //   style: TextStyle(
                                    //     fontSize: 15,
                                    //     fontWeight: FontWeight.w600,
                                    //   ),
                                    // ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFF1E2754),
                                          ),
                                          width: 115,
                                          height: 45,
                                          child: Text(
                                            'Meet',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            reschedule(
                                                "${formatDateEnglish(data.dateMentoring.toString())}, ${timeFormatToHAndM(data.timeMentoring.toString())}",
                                                data.id.toString());
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xFF4DCCC1),
                                            ),
                                            width: 115,
                                            height: 45,
                                            child: Text(
                                              'Reschedule',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                  "Are you sure to cancel mentoring with ${data.user!.name}? \n at ${formatDateEnglish(data.dateMentoring.toString())}, ${timeFormatToHAndM(data.timeMentoring.toString())}"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No")),
                                                TextButton(
                                                    onPressed: () {
                                                      cancelBook(int.parse(
                                                          data.id.toString()));
                                                    },
                                                    child: Text("Yes"))
                                              ],
                                            ),
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.red,
                                            ),
                                            width: 115,
                                            height: 45,
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text("No mentoring data"),
                ),
    );
  }
}
