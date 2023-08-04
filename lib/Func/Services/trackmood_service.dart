// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/Models/trackmood_Model.dart';
import 'package:zenmind/env.dart';
import 'package:http/http.dart' as http;

class TrackMoodService {
  Future<ApiResponse> getByUserAndMonth(
      {required DateTime? date, required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse("${Environment().zendmindBASEURL}api/moods/get"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'month': '${date!.month}',
            'year': '${date.year}'
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              MoodTrackerModel.fromJson(jsonDecode(response.body));
          break;
        case 400:
          apiresponse.error = jsonDecode(response.body)['data'];
          break;
        default:
          apiresponse.error = somethingWentWrong;
          break;
      }
    } catch (err) {
      apiresponse.error = serverError;
    }
    return apiresponse;
  }

  Future<ApiResponse> addMood(
      {required DateTime? date,
      required String? token,
      required String mood}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse("${Environment().zendmindBASEURL}api/moods/add"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'month': '${date!.month}',
            'year': '${date.year}',
            'day': '${date.day}',
            'mood': '$mood'
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data = jsonDecode(response.body)['data'];
          break;
        case 400:
          apiresponse.error = jsonDecode(response.body)['data'];
          break;
        default:
          apiresponse.error = somethingWentWrong;
          break;
      }
    } catch (err) {
      apiresponse.error = serverError;
    }
    return apiresponse;
  }
}
