import 'dart:convert';

import 'package:zenmind/Models/bookhistory_model.dart';
import 'package:zenmind/Models/detailmentor_model.dart';
import 'package:zenmind/Models/listmentor_model.dart';
import 'package:zenmind/Models/listsmentoring_model.dart';
import 'package:zenmind/Models/resbookconsultation_model.dart';
import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/Models/schedulementor_model.dart';
import 'package:zenmind/Models/timeschedule_model.dart';
import 'package:zenmind/env.dart';
import 'package:http/http.dart' as http;

class ConsultationService {
  Future<ApiResponse> getFreeMentor() async {
    ApiResponse apiresponse = ApiResponse();

    try {
      final response = await http.get(
          Uri.parse("${Environment().zendmindBASEURL}api/mentor/all/free"),
          headers: {
            'Accept': 'application/json',
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              ListMentorModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getPaidMentor() async {
    ApiResponse apiresponse = ApiResponse();

    try {
      final response = await http.get(
          Uri.parse("${Environment().zendmindBASEURL}api/mentor/all/paid"),
          headers: {
            'Accept': 'application/json',
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              ListMentorModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getDetailMentor({required int idmentor}) async {
    ApiResponse apiresponse = ApiResponse();

    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/detail/$idmentor"),
          headers: {
            'Accept': 'application/json',
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              DetailMentorModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getTimeSchedule({required int idSchedule}) async {
    ApiResponse apiresponse = ApiResponse();

    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/schedule/time/$idSchedule"),
          headers: {
            'Accept': 'application/json',
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              TimeScheduleModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getDateSchedule(
      {required String idMentor, required String monthYear}) async {
    ApiResponse apiresponse = ApiResponse();

    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/get/schedule/$idMentor/$monthYear"),
          headers: {
            'Accept': 'application/json',
          });

      print(response.body);

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              ScheduleMentorModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getAllBookOngoing({required String? token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse("${Environment().zendmindBASEURL}api/mentor/book/ongoing"),
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

  Future<ApiResponse> gettrxData(
      {required String? token, required String? status}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/book/transaction/get/$status"),
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

  Future<ApiResponse> getHistoryBook({required String token,required String status}) async {
    ApiResponse apiresponse = ApiResponse();

    try {
      final response = await http.get(
          Uri.parse("${Environment().zendmindBASEURL}api/mentor/book/history/$status"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      print(response.body);

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              BookingHistoryModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponseBookConsultation> createBook(
      {required String token,
      required String id_mentor,
      required int fee,
      required String id_date_mentoring,
      required String id_time_mentoring}) async {
    ApiResponseBookConsultation apiresponse = ApiResponseBookConsultation();

    try {
      final response = await http.post(
          Uri.parse("${Environment().zendmindBASEURL}api/mentor/book"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'id_mentor': id_mentor,
            'fee': fee.toString(),
            'id_date_mentoring': id_date_mentoring,
            'id_time_mentoring': id_time_mentoring,
          });

      print("bokkkdata : ");
      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiresponse.type = jsonDecode(response.body)['data']['type'];
          apiresponse.data = jsonDecode(response.body)['data']['data'];
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

  Future<ApiResponse> cancelBook({required int idBook}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse(
            "${Environment().zendmindBASEURL}api/mentor/book/cancel/$idBook"),
        headers: {'Accept': 'application/json'},
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

  Future<ApiResponse> cancelTrx({required String id}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse(
            "${Environment().zendmindBASEURL}api/mentor/book/transaction/cancel/$id"),
        headers: {'Accept': 'application/json'},
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

  Future<ApiResponse> confirmBook({required int idBook}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse(
            "${Environment().zendmindBASEURL}api/mentor/book/confirm/$idBook"),
        headers: {'Accept': 'application/json'},
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

  Future<ApiResponse> reschedule({
    required String idmentoring,
    required String newDate,
    required String newTime,
  }) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/mentor/book/reschedule"),
          headers: {
            'Accept': 'application/json'
          },
          body: {
            'id_mentoring': "1",
            'new_date': newDate,
            'new_time': newTime,
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
}
