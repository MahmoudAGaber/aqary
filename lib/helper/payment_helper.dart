
import 'dart:io';
import 'dart:typed_data';

import 'package:aqary/ViewModel/RealStateViewModel.dart';
import 'package:path_provider/path_provider.dart';

class PaymentHelper{

  static getPayment<String>(int payment, PaymentsSystem paymentsSystem){
    switch(paymentsSystem){
      case PaymentsSystem.annually:
        return payment.toStringAsFixed(1);
      case PaymentsSystem.Semi_annually:
        return (payment/2).toStringAsFixed(1);
      case PaymentsSystem.Quarterly:
        return (payment/4).toStringAsFixed(1);
      case PaymentsSystem.monthly:
        return (payment/12).toStringAsFixed(1);
      default:
        return payment.toString();
    }
  }

  static getArabicPaymentStyle<String>(PaymentsSystem paymentsSystem){
    switch(paymentsSystem){
      case PaymentsSystem.annually:
        return "سنوي";
      case PaymentsSystem.Semi_annually:
        return "نصف سنوي";
      case PaymentsSystem.Quarterly:
        return 'ربع سنوي';
      case PaymentsSystem.monthly:
        return "شهري";
      default:
        return "سنوي";
    }
  }

  static Future<File> uint8ListToFile(Uint8List data) async {

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    String filePath = '$tempPath/temp_image.png';

    File file = File(filePath);
    await file.writeAsBytes(data);

    return file;
  }

  static bool containsEnglish(String text) {
    for (int i = 0; i < text.length; i++) {
      final codeUnit = text.codeUnitAt(i);
      if ((codeUnit >= 65 && codeUnit <= 90) || (codeUnit >= 97 && codeUnit <= 122)) {
        return true;
      }
    }
    return false;
  }
}

