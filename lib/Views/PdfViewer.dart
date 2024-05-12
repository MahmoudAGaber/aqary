

import 'dart:io';

import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  String filePath;
   PdfViewer({super.key,required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "معاينة العقد",
      ),
        body: SfPdfViewer.file(
            File('$filePath')));
  }
}
