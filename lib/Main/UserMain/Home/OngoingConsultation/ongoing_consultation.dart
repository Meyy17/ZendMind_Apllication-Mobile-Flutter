import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/UserMain/Home/home_menu.dart';
import 'package:zenmind/Models/listschedulementor_model.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';

import '../../../../Func/date_fromated.dart';
import '../../../../Widget/Button.dart';
import '../../../../settings_all.dart';
import '../../Consultation/BookConsultation/book_consultation.dart';

class OngoingConsul extends StatefulWidget {
  const OngoingConsul({Key? key}) : super(key: key);

  @override
  State<OngoingConsul> createState() => _OngoingConsulState();
}

class _OngoingConsulState extends State<OngoingConsul> {
  bool isLoad = true;
  String tokenlocaluser = "";
  ListScheduleMentoring dataOngoing = ListScheduleMentoring();

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenlocaluser =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });
    var res =
        await ConsultationService().getAllBookOngoing(token: tokenlocaluser);
    setState(() {
      if (res.error == null) {
        dataOngoing = res.data as ListScheduleMentoring;
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
      // Navigator.pop(context);
      Navigator.pop(context);
      setState(() {
        getData();
      });
    } else {
      print(res.error);
    }
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_circle_left_rounded,
                            color: Color(0xFF4DCCC1),
                            size: 35,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Ongoing",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    itemCount: dataOngoing.data!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var dataMentor = dataOngoing.data![index];
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index % 2 != 0
                              ? Color(0xffF5F5DA)
                              : Color(0xffACD8FE),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 72,
                                  width: 72,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: GetTheme().backgroundGrey(context),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataMentor.mentor!.user!.name.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "• Specialist : ${dataMentor.mentor!.specialist.toString()}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: GetTheme()
                                            .unselectedWidget(context),
                                      ),
                                    ),
                                    Text(
                                      '• Date : ${formatDateEnglish(dataMentor.dateMentoring.toString())}, ${timeFormatToHAndM(dataMentor.timeMentoring.toString())}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: GetTheme()
                                            .unselectedWidget(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF1E2754),
                                      ),
                                      height: 45,
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          "Chat",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatRoom(
                                            id_SecondUser: dataMentor.mentor!.id
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFF1E2754),
                                      ),
                                      height: 45,
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          "Reschedule",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      reschedule(
                                        "${formatDateEnglish(dataMentor.dateMentoring.toString())}, ${timeFormatToHAndM(dataMentor.timeMentoring.toString())}",
                                        dataMentor.id.toString(),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFFF696B),
                                      ),
                                      height: 45,
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      cancelBook(
                                        int.parse(dataMentor.id.toString()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF4DCCC1),
                                  ),
                                  height: 45,
                                  width: 180,
                                  child: Center(
                                    child: Text(
                                      "Rate mentor",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFF589FDC),
                                  ),
                                  height: 45,
                                  width: 180,
                                  child: Center(
                                    child: Text(
                                      "Join meet",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
