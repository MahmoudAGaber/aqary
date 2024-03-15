import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class FileHandleApi {
  // save pdf file function
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    final dir = await getExternalStorageDirectory();
    final file = File('${dir?.path}/$name');
    await file.writeAsBytes(bytes);
    print(file.path);
    return file;
  }


  static Future<Widget> filePath() async {
    final dir = await getExternalStorageDirectory();
   return SfPdfViewer.file(File('${dir?.path}/my_invoice.pdf'));

  }
}