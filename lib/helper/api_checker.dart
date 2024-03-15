// import 'package:aqary/Views/Login.dart';
// import 'package:aqary/helper/route_helper.dart';
// import 'package:flutter/material.dart';
//
// import '../Views/base/custom_snackbar.dart';
// import '../data/model/response/base/api_response.dart';
// import '../data/model/response/base/error_response.dart';
// import '../localization/language_constraints.dart';
// import '../main.dart';
//
// class ApiChecker {
//   static void checkApi(ApiResponse apiResponse) {
//     ErrorResponse error = getError(apiResponse);
//
//     if((error.errors![0].code == '401' || error.errors![0].code == 'auth-001' &&  ModalRoute.of(Get.context!)?.settings.name != RouteHelper.getLoginRoute())) {
//      // Provider.of<SplashProvider>(Get.context!, listen: false).removeSharedData();
//       Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => const Login()), (route) => false);
//     }else {
//       showCustomSnackBar(getTranslated(error.errors![0].message, Get.context!));
//     }
//   }
//
//   static ErrorResponse getError(ApiResponse apiResponse){
//     ErrorResponse error;
//
//     try{
//       error = ErrorResponse.fromJson(apiResponse);
//     }catch(e){
//       if(apiResponse.error != null){
//         error = ErrorResponse.fromJson(apiResponse.error);
//       }else{
//         error = ErrorResponse(errors: [Errors(code: '', message: apiResponse.error.toString())]);
//       }
//     }
//     return error;
//   }
// }