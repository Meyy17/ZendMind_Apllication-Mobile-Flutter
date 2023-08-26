import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenmind/DB/auth_preference.dart';
import 'package:zenmind/Func/Services/consultation_services.dart';
import 'package:zenmind/Func/date_fromated.dart';
import 'package:zenmind/Func/time_formated.dart';
import 'package:zenmind/Main/UserMain/Consultation/BookConsultation/paymentgateway_menu.dart';
import 'package:zenmind/Main/UserMain/Home/home_menu.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isLoad = true;
  String tokenlocaluser = "";
  ListScheduleMentoring dataTrx = ListScheduleMentoring();

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tokenlocaluser =
          sharedPreferences.getString(AuthPreferences.tokenKey) ?? "";
    });
    var res = await ConsultationService()
        .gettrxData(token: tokenlocaluser, status: 'WaitingP');
    setState(() {
      if (res.error == null) {
        dataTrx = res.data as ListScheduleMentoring;
        isLoad = false;
      } else {}
    });
  }

  void setData(String status) async {
    setState(() {
      isLoad = true;
    });
    var res = await ConsultationService()
        .gettrxData(token: tokenlocaluser, status: status);
    setState(() {
      if (res.error == null) {
        dataTrx = res.data as ListScheduleMentoring;
        isLoad = false;
      } else {}
    });
  }

  void cancelBook(String idbook) async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    var res = await ConsultationService().cancelTrx(id: idbook);

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
          'Transaction',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEAEEEF),
              ),
              height: 120,
              width: 400,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setData('WaitingP');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "Assets/Picture/Svg/Pending.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      // print("Completed");
                      setData('finishP');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "Assets/Picture/Svg/Completed.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Cancelled");
                      setData('PCancelled');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "Assets/Picture/Svg/Cancelled.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Cancelled",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Failed");
                      setData('PFailed');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "Assets/Picture/Svg/Failed.png",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Failed",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: const Color(0xFFEAEEEF),
            //   ),
            //   height: 90,
            //   width: 400,
            //   child: const Row(
            //     children: [
            //       Text(
            //         "August • 01 • 2023",
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 15,
            //         ),
            //       ),
            //       Spacer(),
            //       Icon(
            //         Icons.keyboard_arrow_down_outlined,
            //         size: 30,
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),

            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: isLoad
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemCount: dataTrx.data!.length,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFEAEEEF),
                          ),
                          width: 400,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "Assets/Picture/Svg/DoctorProfile.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataTrx.data![index].mentor!.user!.name
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Specialties: ${dataTrx.data![index].mentor!.specialist}",
                                        style: TextStyle(
                                          color: Color(0xFF5C5C5C),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Date mentoring:\n ${formatDateEnglish(dataTrx.data![index].dateMentoring.toString())}, ${timeFormatToHAndM(dataTrx.data![index].timeMentoring.toString())}',
                                        style: TextStyle(
                                          color: Color(0xFF5C5C5C),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Rp. 100.000",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text("Consultation",
                                          style: TextStyle(
                                            color: Color(0xFF3DBA76),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible:
                                    dataTrx.data![index].status == "WaitingP",
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                child: PaymentGatewayWebView(
                                                    urlWebsite: dataTrx
                                                        .data![index].urlTrx
                                                        .toString()),
                                                type: PageTransitionType.fade));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFF4DCCC1),
                                        ),
                                        height: 50,
                                        width: 170,
                                        child: const Text(
                                          "Pay now",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        cancelBook(
                                            dataTrx.data![index].id.toString());
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFFFF696B),
                                        ),
                                        height: 50,
                                        width: 170,
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
