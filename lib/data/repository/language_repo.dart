// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// import '../../utill/app_constants.dart';
// import '../datasource/remote/exception/api_error_handler.dart';
// import '../model/response/base/api_response.dart';
// import '../model/response/language_model.dart';
//
// import '../datasource/remote/dio/dio_client.dart';
//
//
// class LanguageRepo {
//   final DioClient? dioClient;
//
//   LanguageRepo({required this.dioClient});
//
//   List<LanguageModel> getAllLanguages({BuildContext? context}) {
//     return AppConstants.languages;
//   }
//
//   Future<ApiResponse> changeLanguageApi({required String? languageCode}) async {
//     try {
//       Response? response = await dioClient!.post(
//         AppConstants.changeLanguage,
//         data: {'language_code' : languageCode},
//       );
//       return ApiResponse.withSuccess(response);
//     } catch (e) {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
//
// }
