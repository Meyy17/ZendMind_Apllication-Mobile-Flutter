import 'package:intl/intl.dart';

String timeFormatToHAndM(time) {
  DateTime dateTime = DateFormat("HH:mm:ss").parse(time);
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return '${hour}:${minute}';
}
