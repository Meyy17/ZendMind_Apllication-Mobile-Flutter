import 'package:flutter/material.dart';
import 'package:zenmind/Main/UserMain/Consultation/consultation_menu.dart';
import 'package:readmore/readmore.dart';
import 'package:zenmind/Widget/Button.dart';

class BookConsultation extends StatelessWidget {
  const BookConsultation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Column(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConsultationMenu()),
                    );
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
                        const Text(
                          'Lugas Richtigo',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          'Specialties: Anxiety',
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
                      children: const [
                        Text(
                          '10',
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
                    const ReadMoreText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum eros eu fringilla euismod. Sed ut tortor odio. Pellentesque et dolor sed mi consequat vulputate nec ut lectus...   ',
                      trimLines: 2,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Read less',
                      moreStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dateCard(day: 'Mon', date: '5', onPressed: () {}),
                        dateCard(day: 'Tue', date: '6', onPressed: () {}),
                        dateCard(day: 'Wed', date: '7', onPressed: () {}),
                        dateCard(day: 'Thu', date: '8', onPressed: () {}),
                        dateCard(day: 'Fri', date: '9', onPressed: () {}),
                        dateCard(day: 'Sat', date: '10', onPressed: () {}),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        timePicker(time: '09:00', onPressed: () {}),
                        timePicker(time: '10:00', onPressed: () {}),
                        timePicker(time: '11:00', onPressed: () {}),
                      ],
                    )
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
                    onPressed: () {},
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
