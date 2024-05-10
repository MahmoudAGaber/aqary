
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:aqary/Models/ContractModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/RealStateModel.dart';
import '../Models/UserModel.dart';


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
      print(responseBody.body);
      final decodedResponse = json.decode(responseBody.body);
      return decodedResponse;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to make the POST request');
    }
  }

  Future<Map<String, dynamic>> postAnotherData({
    required String endPoint,
    String param = '',
    bool auth = false,
    required String method,
    required Map<String, String> requestBody,
    dynamic model
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = mainUrl + endPoint + param;

    var request = http.MultipartRequest(method, Uri.parse(url));

    // Add headers
    // Authorization
    if (auth) {
      String? token = prefs.getString('token');
      if (token != null) {
        request.headers['Authorization'] = "Bearer $token";
      } else {
        print("Authorization token not found");
        throw Exception('Authentication required but no token found');
      }
    }

    request.fields.addAll(requestBody);
    for (File imagePath in model!.images) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'images', imagePath.path,);
      request.files.add(multipartFile);
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Server responded with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during the $method request: $e');
      throw Exception('Failed to make the $method request');
    }
  }


  Future<Map<String, dynamic>> postContract({
    required String endPoint,
    String param = '',
    bool auth = false,
    required Map<String, String> requestBody,
    String? filePath,
    String? fieldName,
    String? signaturePath,
    String? signatureFieldName
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = mainUrl + endPoint + param;

    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (auth) {
      String? token = prefs.getString('token');
      if (token != null) {
        request.headers['Authorization'] = "Bearer $token";
      } else {
        print("Authorization token not found");
        throw Exception('Authentication required but no token found');
      }
    }

    request.fields.addAll(requestBody);

    if(filePath!.isNotEmpty || filePath !='') {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        fieldName!, filePath,);
      request.files.add(multipartFile);
    }

    if (signaturePath !=null) {
      http.MultipartFile signatureFile = await http.MultipartFile.fromPath(
        signatureFieldName!,
        signaturePath,
      );
      request.files.add(signatureFile);
    }


    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Server responded with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during the POST request: $e');
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
      print(prefs.get('token'));
      if (response.statusCode == 200) {
        dynamic decodedResponse = json.decode(response.body);
        print(decodedResponse);
        return fromJson(decodedResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to make the GET request');
    }
  }

  Future<T> patch<T>({
    required String endPoint,
    String param = '',
    bool auth = false,
    required Map<String, String> requestBody,
    File? file, // Optional parameter for the file
    required T Function(dynamic json) fromJson,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = mainUrl + endPoint + param;
    http.Response response;

    // Add authorization header if required
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (auth) {
      String? token = prefs.getString('token');
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      } else {
        print("Authorization token not found");
        throw Exception('Authentication required but no token found');
      }
    }

    print(file);
    if (file!.path.isNotEmpty) {
      print("OKKKKK");
      var request = http.MultipartRequest('PATCH', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields.addAll(requestBody)
        ..files.add(await http.MultipartFile.fromPath('pic', file.path,));

      try {
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } catch (e) {
        print('Error during the PATCH request with file: $e');
        throw Exception('Failed to make the PATCH request with file');
      }
    } else {
      try {
        response = await http.patch(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(requestBody)
        );
      } catch (e) {
        print('Error during the PATCH request: $e');
        throw Exception('Failed to make the PATCH request');
      }
    }

    if (response.statusCode == 200) {
      dynamic decodedResponse = json.decode(response.body);
      print(decodedResponse);
      return fromJson(decodedResponse);
    } else {
      print('Failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Server responded with status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchPlacemarks(double latitude, double longitude) async {
    final apiKey = 'AIzaSyA1IhkVPes78yBeqR4FcBFSF2eJ7Id9aZY';
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&language=ar&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final results = jsonResponse['results'] as List<dynamic>;
      return results;
    } else {
      throw Exception('Failed to fetch placemarks');
    }
  }
}