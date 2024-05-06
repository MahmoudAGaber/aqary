
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../data/services/FiresbaseServices.dart';

final localImageProvider = StateProvider<File>((ref) => File(""));


class FilePickerHelper {

  static Uint8List? localImgUrl;

   Future<List<File>> pickFiles(bool isOne) async {
    List<File> files = [];
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: isOne? false : true,
        type: FileType.custom,
        allowedExtensions: ['jpeg', 'jpg', 'png', 'flv', 'mkv', 'mov', 'mp4', 'mpeg', 'webm', 'wmv'],
        withData: true
    );
    if (result != null) {
      for (var file in result.files) {
        if (file.bytes != null) {
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;

          File tempFile = File('$tempPath/${file.name}');
          await tempFile.writeAsBytes(file.bytes!);

          files.add(tempFile);
        } else {
          throw Exception('File bytes are null for file: ${file.name}');
        }
      }
    }

    return files;
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