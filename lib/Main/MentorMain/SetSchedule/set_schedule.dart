import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/MentorMain/home_menu.dart';
import 'package:zenmind/Models/listschedulementor_model.dart';

import '../../../DB/auth_preference.dart';
import '../../../Func/Services/mentor_services.dart';
import '../../../Models/listsmentoring_model.dart';

class SetSchedule extends StatefulWidget {
  const SetSchedule({Key? key}) : super(key: key);

  @override
  State<SetSchedule> createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {
  AuthPreferences authPreferences = AuthPreferences();

  String tokenLocalUsers = "";
  bool isLoad = true;
  ListScheduleMentor listSch = ListScheduleMentor();

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });

    var res = await MentorServices().getschedulementor(token: tokenLocalUsers);
    setState(() {
      if (res.error == null) {
        listSch = res.data as ListScheduleMentor;

        isLoad = false;
      } else {}
    });
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

  void addDate() async {
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
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    var res = await MentorServices()
        .addsch(time: time, token: tokenLocalUsers, date: date);

    if (res.error == null) {
      Navigator.pop(context);
      setState(() {
        getData();
      });
    } else {
      print(res.error);
    }
  }

  String formatTime(TimeOfDay timeOfDay) {
    // Format waktu ke dalam format hh:mm:00
    String hour = _twoDigits(timeOfDay.hour);
    String minute = _twoDigits(timeOfDay.minute);
    return "$hour:$minute:00";
  }

  void setTime(String idschedule) async {
    TimeOfDay _selectedTime = TimeOfDay.now();
    String time = "";

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          _selectedTime, // Waktu awal yang ditampilkan pada time picker
    );

    setState(() {
      _selectedTime = picked!;
      time = formatTime(_selectedTime);
    });
    print(time);

    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    var res =
        await MentorServices().addtimesch(time: time, idschedule: idschedule);

    if (res.error == null) {
      Navigator.pop(context);
      setState(() {
        getData();
      });
    } else {
      print(res.error);
    }
  }

  void deleteTime(String idTime) async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    var res = await MentorServices().deletetimesch(idtime: idTime);

    if (res.error == null) {
      Navigator.pop(context);
      setState(() {
        getData();
      });
    } else {
      print(res.error);
    }
  }

  void deleteDate(String idDate) async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    var res = await MentorServices().setfee(fee: 0, token: tokenLocalUsers);

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
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            addDate();
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF1E2754)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
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
            'Set schedule',
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
                        SizedBox(
                          height: 35,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          itemCount: listSch.data!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 15,
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
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            formatDateEnglish(
                                                data.date.toString()),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Wrap(
                                              children: List.generate(
                                                data.timeSchedule!.length,
                                                (i) => Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .all(10)
                                                          .copyWith(left: 0),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Color(
                                                                0xFF00CBC8)),
                                                        width: 80,
                                                        height: 40,
                                                        child: Text(
                                                          timeFormatToHAndM(data
                                                              .timeSchedule![i]
                                                              .time),
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        deleteTime(data
                                                            .timeSchedule![i].id
                                                            .toString());
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 67),
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xFF369B92)),
                                                        child: Icon(
                                                          Icons.close_rounded,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setTime(data.id.toString());
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Color(0xFF1E2754)),
                                              width: 30,
                                              height: 100,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
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
                    child: Text("No Schedule"),
                  ));
  }
}
