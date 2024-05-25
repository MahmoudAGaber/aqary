

import 'dart:io';

import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  String filePath;
  bool isUrl;
   PdfViewer({super.key,required this.filePath,required this.isUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "معاينة العقد",
      ),
        body: isUrl
            ?SfPdfViewer.network(filePath)
            :SfPdfViewer.file(
            File('$filePath'))
    );
  }
}
