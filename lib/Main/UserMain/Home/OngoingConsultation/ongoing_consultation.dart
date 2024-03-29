import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/AllRoleMain/voiceCall/voice_screen.dart';
import 'package:zenmind/Main/UserMain/Home/home_menu.dart';
import 'package:zenmind/Models/listschedulementor_model.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';
import 'package:zenmind/Widget/InputText.dart';
import 'package:zenmind/env.dart';

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

  void doneConfirm(String idbook, String idMentor) async {
    TextEditingController ctrlReview = TextEditingController();
    double rate = 0;
    await showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        // height: GetSizeScreen().height(context) * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: GetSizeScreen().height(context) * 0.5,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Rate Mentor",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        rate = rating;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 4,
                      controller: ctrlReview,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          // prefixIcon: Icon(Icons.notes),
                          filled: true,
                          fillColor: GetTheme().backgroundGrey(context),
                          hintStyle: const TextStyle(fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          hintText: "Review"),
                    ),
                    Text(
                        "Silahkan klik konfirmasi selesai langsung jika tidak ingin memberi rating")
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1E2754),
                    ),
                    height: 45,
                    // width: double.infinity,
                    child: Center(
                      child: Text(
                        "Konfirmasi selesai",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    var res = await ConsultationService().finishBook(
        idmentor: idMentor,
        token: tokenlocaluser,
        idBook: idbook,
        rate: rate.toString(),
        notes: ctrlReview.text);

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
          'On Going',
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: dataOngoing.data!.length,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var dataMentor = dataOngoing.data![index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              dataMentor.mentor!.user!.imgProfileURL != ""
                                  ? Container(
                                      height: 72,
                                      width: 72,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            GetTheme().backgroundGrey(context),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          Environment().zendmindBASEURL +
                                              dataMentor
                                                  .mentor!.user!.imgProfileURL
                                                  .toString(),
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey[200]!,
                                                  highlightColor:
                                                      Colors.grey[350]!,
                                                  child: Center(
                                                    child: Container(
                                                      height: 72,
                                                      width: 72,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: GetTheme()
                                                            .backgroundGrey(
                                                                context),
                                                      ),
                                                      child: Icon(
                                                        Icons.person,
                                                        color: Colors.white,
                                                        size: 32,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Center(
                                              child: Container(
                                                height: 72,
                                                width: 72,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: GetTheme()
                                                      .backgroundGrey(context),
                                                ),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 32,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        height: 72,
                                        width: 72,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: GetTheme()
                                              .backgroundGrey(context),
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 32,
                                        ),
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
                                      color:
                                          GetTheme().unselectedWidget(context),
                                    ),
                                  ),
                                  Text(
                                    '• Date : ${formatDateEnglish(dataMentor.dateMentoring.toString())}, ${timeFormatToHAndM(dataMentor.timeMentoring.toString())}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          GetTheme().unselectedWidget(context),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          username: dataMentor
                                              .mentor!.user!.name
                                              .toString(),
                                          id_SecondUser: dataMentor
                                              .mentor!.user!.id
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
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
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: DateTime.now().isBefore(
                                          formatToDatetime(
                                              date: dataMentor.dateMentoring
                                                  .toString(),
                                              time: dataMentor.timeMentoring
                                                  .toString()))
                                      ? null
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                  "Are you sure to confirm consultation to done?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("No")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      doneConfirm(
                                                          dataMentor.id
                                                              .toString(),
                                                          dataMentor.idMentor
                                                              .toString());
                                                    },
                                                    child: Text("Yes"))
                                              ],
                                            ),
                                          );
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: DateTime.now().isBefore(
                                              formatToDatetime(
                                                  date: dataMentor.dateMentoring
                                                      .toString(),
                                                  time: dataMentor.timeMentoring
                                                      .toString()))
                                          ? Colors.grey[400]
                                          : Color(0xFF1E2754),
                                    ),
                                    height: 45,
                                    // width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        "Konfirmasi selesai",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: DateTime.now().isBefore(
                                          formatToDatetime(
                                              date: dataMentor.dateMentoring
                                                  .toString(),
                                              time: dataMentor.timeMentoring
                                                  .toString()))
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CallMenu(
                                                username: dataMentor
                                                    .mentor!.user!.name
                                                    .toString(),
                                                id_SecondUser: dataMentor
                                                    .mentor!.user!.id
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: DateTime.now().isBefore(
                                              formatToDatetime(
                                                  date: dataMentor.dateMentoring
                                                      .toString(),
                                                  time: dataMentor.timeMentoring
                                                      .toString()))
                                          ? Colors.grey[400]
                                          : Color(0xFF589FDC),
                                    ),
                                    height: 45,
                                    // width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        "Join meet",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 30,
                ),
              ),
            ),
    );
  }
}
