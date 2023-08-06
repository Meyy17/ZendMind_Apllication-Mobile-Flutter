import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Func/money_formated.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/AllRoleMain/Messages/chat_screen.dart';
import 'package:zenmind/Main/UserMain/Consultation/BookConsultation/paymentgateway_menu.dart';
import 'package:zenmind/Main/UserMain/Consultation/consultation_menu.dart';
import 'package:readmore/readmore.dart';
import 'package:zenmind/Main/UserMain/navigation_menu.dart';
import 'package:zenmind/Models/detailmentor_model.dart';
import 'package:zenmind/Models/profilementor_model.dart';
import 'package:zenmind/Models/schedulementor_model.dart';
import 'package:zenmind/Models/timeschedule_model.dart';
import 'package:zenmind/Widget/Button.dart';
import 'package:zenmind/env.dart';
import 'package:zenmind/settings_all.dart';

import '../../../../Func/date_fromated.dart';

class BookConsultation extends StatefulWidget {
  const BookConsultation({Key? key, required this.idMentor}) : super(key: key);
  final int idMentor;

  @override
  State<BookConsultation> createState() => _BookConsultationState();
}

class _BookConsultationState extends State<BookConsultation> {
  bool isLoad = true;
  bool isValidate = false;
  DetailMentorModel mentorData = DetailMentorModel();
  ScheduleMentorModel scheduleMentor = ScheduleMentorModel();
  bool isLoadTimeSchedule = false;
  TimeScheduleModel timeSchedule = TimeScheduleModel();
  String idDateSelected = "";
  String idTimeDateSelected = "";
  String tokenLocalUsers = "";
  DateTime selectedDate = DateTime.now();

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
      setState(() {
        isLoad = true;
      });
      var res = await ConsultationService().createBook(
          fee: mentorData.data!.mentorData!.fee ?? 0,
          id_date_mentoring: idDateSelected,
          id_time_mentoring: idTimeDateSelected,
          id_mentor: mentorData.data!.mentorData!.id.toString(),
          token: tokenLocalUsers);

      if (res.error == null) {
        if (res.type == 'Free') {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                    id_SecondUser:
                        mentorData.data!.mentorData!.user!.id.toString()),
              ));
          setState(() {
            isLoad = false;
            getData();
          });
        } else {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentGatewayWebView(
                  urlWebsite: res.data.toString(),
                ),
              ));
          setState(() {
            isLoad = false;
            getData();
          });
        }

        print(res.data);
      } else if (res.type == 'Paid') {
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
        // }
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

  void getDateSchedule() async {
    setState(() {
      isLoad = true;
    });
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(selectedDate.toString());

    var m = DateFormat('MM').format(dateTime);
    var Y = DateFormat('yyyy').format(dateTime).toString();
    var res = await ConsultationService().getDateSchedule(
        idMentor: mentorData.data!.mentorData!.id.toString(),
        monthYear: '$Y-$m');
    setState(() {
      if (res.error == null) {
        scheduleMentor = res.data as ScheduleMentorModel;
        isLoadTimeSchedule = false;
        isLoad = false;
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
        getDateSchedule();
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

  double rateFormat(double rate) {
    if (rate == 0) {
      rate = 0.0;
    } else if (rate == 1) {
      rate = 1.0;
    } else if (rate == 2) {
      rate = 2.0;
    } else if (rate == 3) {
      rate = 3.0;
    } else if (rate == 4) {
      rate = 4.0;
    } else if (rate == 5) {
      rate = 5.0;
    } else {
      rate = rate;
    }

    return rate;
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
          'Book Consultation',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: mentorData.data!.mentorData!.user!
                                              .imgProfileURL !=
                                          null
                                      ? Image.network(
                                          Environment().zendmindBASEURL +
                                              mentorData.data!.mentorData!.user!
                                                  .imgProfileURL
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
                                                      height: 120,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
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
                                                height: 120,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                        )
                                      : Center(
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                ),
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
                                    '${mentorData.data!.mentorData!.user!.name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Specialties: ${mentorData.data!.mentorData!.specialist}',
                                    style: TextStyle(
                                      color: Color(0xFF5C5C5C),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    mentorData.data!.mentorData!.fee == 0
                                        ? 'fee: Free'
                                        : 'fee: ${MoneyFormated.convertToIdrWithSymbol(count: mentorData.data!.mentorData!.fee, decimalDigit: 2)}',
                                    style: TextStyle(
                                      color: Color(0xFF5C5C5C),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star_rate_rounded,
                                        color: Colors.orangeAccent,
                                        size: 30,
                                      ),
                                      Text(
                                        rateFormat(double.parse(mentorData
                                                .data!.averageRate
                                                .toString()))
                                            .toString(),
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
                                        '${mentorData.data!.ratingCount} Reviews',
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
                                children: [
                                  Text(
                                    '${mentorData.data!.ratingCount}',
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
                                children: [
                                  Text(
                                    '${mentorData.data!.patientCount}',
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
                                    exp(DateTime.parse(mentorData
                                            .data!.mentorData!.createdAt
                                            .toString()))
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
                                '${mentorData.data!.mentorData!.about}',
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Schedules',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final picked =
                                            await showMonthYearPicker(
                                                context: context,
                                                initialDate: selectedDate,
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2100));
                                        if (picked != null &&
                                            picked != selectedDate) {
                                          setState(() {
                                            selectedDate = picked;
                                            idDateSelected = "";
                                            idTimeDateSelected = "";
                                            getDateSchedule();
                                            getTimeSchedule(0);
                                          });
                                        }
                                      },
                                      child: Text(
                                        formatDateToIdOnlyMonthAndYears(
                                            date: selectedDate.toString()),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              scheduleMentor.data!.length <= 0
                                  ? Center(
                                      child: Text("schedule not available"))
                                  : Wrap(
                                      alignment: WrapAlignment.start,
                                      runSpacing: 10,
                                      spacing: 10,
                                      children: List.generate(
                                          scheduleMentor.data!.length, (index) {
                                        var dataSch =
                                            scheduleMentor.data![index];
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              idDateSelected =
                                                  dataSch.id.toString();
                                              idTimeDateSelected = "";
                                              getTimeSchedule(dataSch.id ?? 0);
                                              if (idDateSelected != "" &&
                                                  idTimeDateSelected != "") {
                                                isValidate = true;
                                              } else {
                                                isValidate = false;
                                              }
                                            });
                                          },
                                          child: dateCard(
                                            isSelected: idDateSelected ==
                                                    dataSch.id.toString()
                                                ? true
                                                : false,
                                            day: formatDayName(
                                                    dataSch.date.toString())
                                                .toString(),
                                            date: formattoDay(
                                                    dataSch.date.toString())
                                                .toString(),
                                          ),
                                        );
                                      }),
                                    )
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
                              isLoadTimeSchedule
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : idDateSelected != ""
                                      ? Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: List.generate(
                                              timeSchedule.data!.length,
                                              (index) => InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        idTimeDateSelected =
                                                            timeSchedule
                                                                .data![index].id
                                                                .toString();
                                                        if (idDateSelected !=
                                                                "" &&
                                                            idTimeDateSelected !=
                                                                "") {
                                                          isValidate = true;
                                                        } else {
                                                          isValidate = false;
                                                        }
                                                      });
                                                    },
                                                    child: timePicker(
                                                        time: timeFormatToHAndM(
                                                            timeSchedule
                                                                .data![index]
                                                                .time
                                                                .toString()),
                                                        isSelected:
                                                            idTimeDateSelected ==
                                                                    timeSchedule
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString()
                                                                ? true
                                                                : false),
                                                  )),
                                        )
                                      : Center(
                                          child: Text(
                                              "please select a date in advance"),
                                        )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              style: const ButtonStyle(),
                              onPressed: isValidate
                                  ? () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Text(
                                              "Are you sure to cancel mentoring with ${mentorData.data!.mentorData!.username}?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("No")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  handleBookNow();
                                                },
                                                child: Text("Yes"))
                                          ],
                                        ),
                                      );
                                    }
                                  : null,
                              child: const Text(
                                'Book now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                    id_SecondUser: mentorData
                                        .data!.mentorData!.idUser
                                        .toString(),
                                  ),
                                ));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                color: GetTheme().primaryColor(context),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Icon(
                              Icons.message,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
      ),
    );
  }
}
