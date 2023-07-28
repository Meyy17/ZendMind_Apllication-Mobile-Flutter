import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenmind/Models/trackmood_Model.dart';
import 'package:zenmind/Widget/CustomLeading.dart';
import 'package:zenmind/settings_all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrackerMoodWidget {
  Widget chartMood({required context, required MoodTrackerModel? moodData}) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Grafik Moodmu",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: GetTheme().backgroundGrey(context),
                borderRadius: BorderRadius.circular(10)),
            child: LineChartWidget(moodData!.data!.moodData!),
          ),
        ),
      ],
    );
  }

  Widget listMood({required context, required MoodTrackerModel? moodData}) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: const [
            Text(
              "Grafik Moodmu",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        leadingWithArrow(
            context: context,
            title: "Senang",
            subtitle: "Jumlah mood : ${moodData!.data!.happyCount}",
            leading: templateFeelIconsNoTitle(
                bgColor: const Color(0xffEF5DA8),
                svgIconsName: 'FeelHappyIcons.svg'),
            colorWidget: const Color(0xffEF5DA8)),
        const SizedBox(
          height: 10,
        ),
        leadingWithArrow(
          context: context,
          title: "Sedih",
          subtitle: "Jumlah mood : ${moodData.data!.sadCount}",
          leading: templateFeelIconsNoTitle(
              bgColor: const Color(0xff4DCCC1),
              svgIconsName: 'FeelSadIcons.svg'),
          colorWidget: const Color(0xff4DCCC1),
        ),
        const SizedBox(
          height: 10,
        ),
        leadingWithArrow(
          context: context,
          title: "Biasa Saja",
          subtitle: "Jumlah mood : ${moodData.data!.normalCount}",
          leading: templateFeelIconsNoTitle(
              bgColor: const Color(0xff00CE90),
              svgIconsName: 'FeelNormalIcons.svg'),
          colorWidget: const Color(0xff00CE90),
        ),
        const SizedBox(
          height: 10,
        ),
        leadingWithArrow(
          context: context,
          title: "Marah",
          subtitle: "Jumlah mood : ${moodData.data!.angryCount}",
          leading: templateFeelIconsNoTitle(
              bgColor: const Color(0xffFF696B),
              svgIconsName: 'FeelAngryIcons.svg'),
          colorWidget: const Color(0xffFF696B),
        ),
      ],
    );
  }
}

Widget templateFeelIconsNoTitle(
    {required Color bgColor, required String svgIconsName}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(8))),
    child: Center(
      child: SvgPicture.asset(svgAssetsLocation + svgIconsName),
    ),
  );
}

class LineChartWidget extends StatelessWidget {
  final List<MoodData> data;

  LineChartWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(), // Use CategoryAxis for string values
        primaryYAxis: NumericAxis(),
        series: <LineSeries<MoodData, String>>[
          // Change the type to String
          LineSeries<MoodData, String>(
            // Change the type to String
            dataSource: data,
            xValueMapper: (MoodData moodData, _) =>
                DateTime.parse(moodData.monthYear.toString())
                    .day
                    .toString(), // Use monthYear as the x-value
            xAxisName: 'Month-Year',
            yValueMapper: (MoodData moodData, _) =>
                getMoodValue(moodData.mood.toString()),
            yAxisName: 'Mood',
          ),
        ],
      ),
    );
  }
}

int getMoodValue(String mood) {
  switch (mood) {
    case "happy":
      return 1;
    case "normal":
      return 2;
    case "sad":
      return 3;
    case "angry":
      return 4;
    default:
      return 0;
  }
}
