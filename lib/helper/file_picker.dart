
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/FirestoreServices.dart';

final localImage = StateProvider<String>((ref) => "");


class FilePickerHelper {

  static Uint8List? localImgUrl;

  static void pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png', 'flv', 'mkv', 'mov', 'mp4', 'mpeg', 'webm', 'wmv'],
    );
    if (result != null) {
      List<MultipartFile> files = result.files.map((file) =>
          MultipartFile.fromBytes(
            file.bytes as List<int>,
            filename: file.name,
          ))
          .toList();

      var formData = FormData.fromMap({
        'id': '',
        'type': '',
        'docType': '',
        'files': files,
      });
      for (var element in formData.files) {
        print("OKKK${element.value.filename}");
      }
    }
  }

   Future<String> pickFile(chatRoomId,messageType) async {
    FirebaseServices firebaseServices = FirebaseServices();
    String? imageUrl;
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print("File ${file.path}");

      try {
        List<int> fileBytes = await File(file.path!).readAsBytes();

        if (fileBytes.isNotEmpty) {
          Uint8List uint8List = Uint8List.fromList(fileBytes);
          localImgUrl = uint8List;

          FirebaseServices().sendMessage(chatRoomId, localImgUrl, messageType);

          imageUrl = await firebaseServices.uploadFile(uint8List, file.name);
        } else {
          print("Please select a valid file.");
        }
        return imageUrl!;
      } catch (e) {
        print('Error: $e');
      }
    }
    return imageUrl!;
  }


}