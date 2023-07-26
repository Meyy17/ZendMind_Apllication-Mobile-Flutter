import 'dart:convert';

import 'package:zenmind/Models/profilementor_model.dart';
import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/env.dart';
import 'package:http/http.dart' as http;

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
}
