
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RequestHandler {
  static const mainUrl = "http://ec2-51-20-96-110.eu-north-1.compute.amazonaws.com/api";
  String apiUrl = "https://ka75jyg4kmsc2kcd.us-east-1.aws.endpoints.huggingface.cloud";
  String accessToken = "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";


  Future<Map> postData({endPoint,String parma='',auth = false ,required Map<String,dynamic> requestBody}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.Request('POST', Uri.parse(mainUrl + endPoint  + parma))
      ..headers.addAll( auth ? {
        "Authorization" : "Bearer ${prefs.get('token')}",
        "Content-Type" : "application/json; charset=UTF-8"
      } : {
        "Content-Type" : "application/json; charset=UTF-8"
      }) //if
      ..body = jsonEncode(requestBody);
    try {
      final response = await http.Client().send(request);

      final responseBody = await http.Response.fromStream(response);
      final decodedResponse = json.decode(responseBody.body);
      return decodedResponse;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to make the POST request');
    }
  }
}