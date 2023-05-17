// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenmind/Models/auth_model.dart';
import 'package:zenmind/Models/response_model.dart';
import 'package:zenmind/Models/user_model.dart';
import 'package:zenmind/env.dart';

class AuthServices {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse("${Environment().zendmindBASEURL}api/auth/login"),
          headers: {'Accept': 'application/json'},
          body: {'email': email, 'password': password});

      switch (response.statusCode) {
        case 200:
          apiresponse.data = LoginModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> register(
      {required String email,
      required String password,
      required String name}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse("${Environment().zendmindBASEURL}api/auth/user/register"),
          headers: {'Accept': 'application/json'},
          body: {'email': email, 'password': password, 'name': name});

      switch (response.statusCode) {
        case 200:
          apiresponse.data = RegisterModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> sendVerifyEmail({required String email}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.parse("${Environment().zendmindBASEURL}api/auth/sendVerifyEmail"),
          headers: {'Accept': 'application/json'},
          body: {'email': email});

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

  Future<ApiResponse> getUsers({required String token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse("${Environment().zendmindBASEURL}api/auth/user"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiresponse.data = UserModel.fromJson(jsonDecode(response.body));
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

  Future<ApiResponse> logOut({required String token}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.delete(
          Uri.parse("${Environment().zendmindBASEURL}api/auth/logout"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
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

  Future<ApiResponse> updateDisplay(
      {required String token, required String name}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.put(
          Uri.parse("${Environment().zendmindBASEURL}api/auth/update/display"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'name': name
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

  Future<ApiResponse> checkVerifyEmail({required String email}) async {
    ApiResponse apiresponse = ApiResponse();
    try {
      final response = await http.get(
          Uri.parse(
              "${Environment().zendmindBASEURL}api/auth/checkEmailStatus/$email"),
          headers: {'Accept': 'application/json'});

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
