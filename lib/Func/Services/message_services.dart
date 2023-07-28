import 'dart:convert';

import 'package:zenmind/Models/message_model.dart';
import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/env.dart';
import 'package:http/http.dart' as http;

import '../../Models/listchat_model.dart';

class MessageServices {
  Future<ApiResponse> getListChat({required String token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse("${Environment().zendmindBASEURL}api/messages/listroom"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data = ListChatModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> getMessage(
      {required String token, required String roomID}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/messages/chat/$roomID"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data =
              messageContentModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> createChat(
      {required String token,
      required String roomID,
      required String id_SecondUser,
      required String message}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse("${Environment().zendmindBASEURL}api/messages"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'roomID': roomID,
            'id_SecondUser': id_SecondUser,
            'message': message,
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
