import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/UserMain/Consultation/consultation_menu.dart';
import 'package:readmore/readmore.dart';
import 'package:zenmind/Main/UserMain/navigation_menu.dart';
import 'package:zenmind/Models/detailmentor_model.dart';
import 'package:zenmind/Models/timeschedule_model.dart';
import 'package:zenmind/Widget/Button.dart';

class BookConsultation extends StatefulWidget {
  const BookConsultation({Key? key, required this.idMentor}) : super(key: key);
  final int idMentor;

  @override
  State<BookConsultation> createState() => _BookConsultationState();
}

class _BookConsultationState extends State<BookConsultation> {
  bool isLoad = true;
  DetailMentorModel mentorData = DetailMentorModel();
  bool isLoadTimeSchedule = false;
  TimeScheduleModel timeSchedule = TimeScheduleModel();
  String idDateSelected = "";
  String idTimeDateSelected = "";
  String tokenLocalUsers = "";

  void handleBookNow() async {
    if (idDateSelected == "") {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: "Mohon memilih tanggal book",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (idTimeDateSelected == "") {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: "Mohon memilih waktu book",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      if (mentorData.data!.fee! > 0) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: "Payment gateway sedang tahap pengembangan",
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        setState(() {
          isLoad = true;
        });
        var res = await ConsultationService().createBook(
            fee: mentorData.data!.fee ?? 0,
            id_date_mentoring: idDateSelected,
            id_time_mentoring: idTimeDateSelected,
            id_mentor: mentorData.data!.id.toString(),
            token: tokenLocalUsers);

        if (res.error == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                    id_SecondUser: mentorData.data!.user!.id.toString()),
              ));

          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: res.data.toString(),
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: res.error.toString(),
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      }
    }
  }

  void getTimeSchedule(int idScheduleData) async {
    setState(() {
      isLoadTimeSchedule = true;
    });
    var res =
        await ConsultationService().getTimeSchedule(idSchedule: idScheduleData);
    setState(() {
      if (res.error == null) {
        timeSchedule = res.data as TimeScheduleModel;
        isLoadTimeSchedule = false;
      } else {}
    });
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res =
        await ConsultationService().getDetailMentor(idmentor: widget.idMentor);
    setState(() {
      tokenLocalUsers =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
      if (res.error == null) {
        mentorData = res.data as DetailMentorModel;
        isLoad = false;
      } else {}
    });
  }

  String exp(DateTime date) {
    DateTime datenow = DateTime.now();
    int differenceMonths =
        (datenow.year - date.year) * 12 + datenow.month - date.month;
    double differenceYears = differenceMonths / 12;

    String formattedPercentage = (differenceYears).toStringAsFixed(1);

    // print("Selisih bulan: $differenceMonths bulan");
    // print("Persentase perbedaan tahun: $formattedPercentage tahun");
    return formattedPercentage;
  }

  int formattoDay(String dateR) {
    DateTime date = DateTime.parse(dateR);
    int day = date.day;
    return day;
  }

  String formatDayName(String dateR) {
    DateTime date = DateTime.parse(dateR);
    int dayOfWeek = date.weekday;

    switch (dayOfWeek) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "-";
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
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                        'Book Consultation',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'Assets/Picture/Svg/DoctorPhoto.png',
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                '${mentorData.data!.user!.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Specialties: ${mentorData.data!.specialist}',
                                style: TextStyle(
                                  color: Color(0xFF5C5C5C),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.orangeAccent,
                                    size: 30,
                                  ),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    '•',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color(0xFF5C5C5C)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    '127 Reviews',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color(0xFF5C5C5C)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: const [
                              Text(
                                '127',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF5C5C5C),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 2,
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(200)),
                          ),
                          Column(
                            children: const [
                              Text(
                                '243',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Patients',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF5C5C5C),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 2,
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(200)),
                          ),
                          Column(
                            children: [
                              Text(
                                exp(DateTime.parse(
                                        mentorData.data!.createdAt.toString()))
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Years exp.',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF5C5C5C),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'About Me',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ReadMoreText(
                            '${mentorData.data!.about}',
                            trimLines: 2,
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Read less',
                            moreStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Schedules',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              itemCount:
                                  mentorData.data!.scheduleMentor!.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 10,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                var dataSch =
                                    mentorData.data!.scheduleMentor![index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      idDateSelected = dataSch.id.toString();
                                      idTimeDateSelected = "";
                                      getTimeSchedule(dataSch.id ?? 0);
                                    });
                                  },
                                  child: dateCard(
                                    isSelected:
                                        idDateSelected == dataSch.id.toString()
                                            ? true
                                            : false,
                                    day: formatDayName(dataSch.date.toString())
                                        .toString(),
                                    date: formattoDay(dataSch.date.toString())
                                        .toString(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Choose time',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              child: isLoadTimeSchedule
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : idDateSelected != ""
                                      ? ListView.separated(
                                          itemCount: timeSchedule.data!.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            width: 10,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  idTimeDateSelected =
                                                      timeSchedule
                                                          .data![index].id
                                                          .toString();
                                                });
                                              },
                                              child: timePicker(
                                                  time: timeSchedule
                                                      .data![index].time
                                                      .toString(),
                                                  isSelected:
                                                      idTimeDateSelected ==
                                                              timeSchedule
                                                                  .data![index]
                                                                  .id
                                                                  .toString()
                                                          ? true
                                                          : false),
                                            );
                                          },
                                        )
                                      : Text("-")),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: const ButtonStyle(),
                          onPressed: () {
                            handleBookNow();
                          },
                          child: const Text(
                            'Book now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
  }
}
