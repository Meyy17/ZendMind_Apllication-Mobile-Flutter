// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:zenmind/Models/articles_model.dart';
import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/env.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getArticle() async {
  ApiResponse apiresponse = ApiResponse();
  try {
    final response = await http.get(
        Uri.parse("https://apizendmind.igniteteam.id/api/articles"),
        headers: {
          'Accept': 'application/json',
        });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = ArticlesModel.fromJson(jsonDecode(response.body));
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
