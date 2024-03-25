
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RequestHandler {
  static const mainUrl = "http://ec2-18-215-170-174.compute-1.amazonaws.com:5000/api";
  String accessToken = "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";


  Future<Map> postData({endPoint, String parma = '', auth = false, required Map<String, dynamic> requestBody}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.Request('POST', Uri.parse(mainUrl + endPoint + parma))
      ..headers.addAll(auth ? {
        "Authorization": "Bearer ${prefs.get('token')}",
        "Content-Type": "application/json; charset=UTF-8"
      } : {
        "Content-Type": "application/json; charset=UTF-8"
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


  Future<T> getData<T>({
    required String endPoint,
    String param = '',
    bool auth = false,
    required T Function(dynamic json) fromJson,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = mainUrl + endPoint + param;

    try {
      http.Response response;

      if (auth) {
        response = await http.get(
          Uri.parse(url),
          headers: {
            "Authorization": "Bearer ${prefs.get('token')}",
            "Content-Type": "application/json; charset=UTF-8"
          },
        );
      } else {
        response = await http.get(Uri.parse(url));
      }

      if (response.statusCode == 200) {
        dynamic decodedResponse = json.decode(response.body);
        return fromJson(decodedResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to make the GET request');
    }
  }
}