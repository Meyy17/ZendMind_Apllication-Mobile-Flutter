import 'dart:convert';

import 'package:zenmind/Models/getrate_model.dart';
import 'package:zenmind/Models/listschedulementor_model.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';
import 'package:zenmind/Models/profilementor_model.dart';
import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/env.dart';
import 'package:http/http.dart' as http;

import '../../Models/earning_model.dart';

class MentorServices {
  Future<ApiResponse> getProfileMentor({required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse("${Environment().zendmindBASEURL}api/mentor/profile/get"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      print(response.body);

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              MentorProfileModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getAllScheduleMentoring({required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/get/book/all"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              ListScheduleMentoring.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getHistoryScheduleMentoring(
      {required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/get/book/history"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              ListScheduleMentoring.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getReview({required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/get/review"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      switch (response.statusCode) {
        case 200:
          apiresponse.data = GetRateModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getEarning({required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/get/earning"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              GetEarningModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getTodayScheduleMentoring(
      {required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/get/book/today"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              ListScheduleMentoring.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> setfee({required String token, required int fee}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.put(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/set/fee"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'fee': fee.toString()
          });

      print(response.body);
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

  Future<ApiResponse> addsch(
      {required String token,
      required String time,
      required String date}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/set/schedule"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'time': time,
            'date': date
          });

      print(response.body);
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

  Future<ApiResponse> addtimesch(
      {required String time, required String idschedule}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/set/schedule/time"),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            'time': time,
            'id_schedule': idschedule
          });

      print(response.body);
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

  Future<ApiResponse> deletetimesch({required String idtime}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse(
            "${Environment().zendmindBASEURL}api/mentor/profile/set/schedule/time/delete/$idtime"),
        headers: {
          'Accept': 'application/json',
        },
      );

      print(response.body);
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

  Future<ApiResponse> getschedulementor({required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/profile/get/schedule"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              ListScheduleMentor.fromJson(jsonDecode(response.body));
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
