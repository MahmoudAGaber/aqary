import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart';
import '../ViewModel/ContractViewModel.dart';
import '../helper/payment_helper.dart';
import '../utill/FileHandleApi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<File> generate({
    required WidgetRef signature,
    required String todayDate,
    required String from,
    required String to,
    required String rentPeriod,
    required String location,
    required String titleRent,
    required String payment,
    required String paymentStyle,
    required String ownerName,
    required String renterName,
    required String notes,
    required bool isOwner,
    required Uint8List renterSignature
  }) async {
    final pdf = pw.Document();

    final iconImage = (await rootBundle.load('assets/images/file.png')).buffer.asUint8List();


    var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));
    var arabicFontBold = Font.ttf(await rootBundle.load("assets/fonts/Amiri-Bold.ttf"));
    var englishFont = Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));


    TextStyle textStyle = pw.TextStyle(fontSize: 16);

    final PdfPageFormat customPageFormat = PdfPageFormat(500, 1080);


    pdf.addPage(
      pw.Page(
        pageFormat: customPageFormat ,
        margin: EdgeInsets.only(left: 18,right: 18,top: 12),
        theme: ThemeData.withFont(
          base: englishFont,
        ),
        build: (context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text("وثــــيــــقة إيــــجــــار",
                  style: pw.TextStyle(fontSize: 18,font: arabicFontBold,fontStyle: pw.FontStyle.italic),

                ),

                SizedBox(width: 160,
               child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 8),
                child:  pw.Divider(thickness: .5,color: PdfColors.black),
               )),

                pw.Paragraph(
                  text: todayDate != null || todayDate.isNotEmpty? ' التاريخ: ${todayDate}':'التاريخ : -----------------------------------------------',
                    style: textStyle.copyWith(font: arabicFont),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero
                ),
                Row(
                  children:[
                    pw.Paragraph(
                        text: 'الرقم : ',
                        style: textStyle.copyWith(font: arabicFont),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero
                    ),
                    pw.Paragraph(
                        text: location.isNotEmpty || location !=null
                            ? "$location"
                            :'------------------------------------------------',
                        style: textStyle.copyWith(font: PaymentHelper.containsEnglish(location) ? englishFont:arabicFont),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero
                    ),
                  ]
                ),
                pw.Column(
                  children:
                    [
                      Row(
                        children:[
                          pw.Paragraph(
                              text: 'المؤجر : ',
                              style: textStyle.copyWith(font:arabicFont),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                          pw.Paragraph(
                              text: ownerName.isNotEmpty
                                  ?"$ownerName"
                                  :'-----------------------------------------',
                              style: textStyle.copyWith(font: PaymentHelper.containsEnglish(ownerName) ? englishFont:arabicFont),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                        ]
                      ),
                      pw.SizedBox(width: 20),
                      Row(
                        children: [
                          pw.Paragraph(
                              text: 'المستأجر : ',
                              style: textStyle.copyWith(font: arabicFont),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                          pw.Paragraph(
                              text: renterName.isNotEmpty
                                  ?"$renterName"
                                  :'-----------------------------------------',
                              style: textStyle.copyWith(font: PaymentHelper.containsEnglish(ownerName) ? englishFont:arabicFont,),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                        ]
                      )

                    ]
                ),
                Row(
                  children:
                    [
                      pw.Paragraph(
                          text: 'موضوع الإيجار :',
                        style: textStyle.copyWith(font: arabicFont),
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,

                      ),
                      pw.Paragraph(
                          text: titleRent.isNotEmpty || titleRent!=null ? " $titleRent " :'-------------------------------------------',
                          style: textStyle.copyWith(font: PaymentHelper.containsEnglish(ownerName) ? englishFont:arabicFont,),
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero
                      ),
                    ]
                ),

                pw.Row(
                  children: [
                    pw.Paragraph(
                        text: 'مدة الإيجار : ',
                        style: textStyle.copyWith(font: arabicFont),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero
                    ),
                    pw.Paragraph(
                        text: rentPeriod.isNotEmpty || rentPeriod!=null
                            ? rentPeriod
                            : '------------------------------------------',
                        style: textStyle.copyWith(font: arabicFont),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero
                    ),
                  ]
                ),

                pw.Row(
                  children:
                    [
                      pw.Row(
                        children: [
                          pw.Paragraph(
                              text: 'من : ',
                              style: textStyle.copyWith(font: arabicFont),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                          pw.Paragraph(
                              text: from.isNotEmpty || from !=null
                                  ? from
                                  :' -----------------------------',
                              style: textStyle.copyWith(font: englishFont),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                        ]
                      ),
                      pw.SizedBox(width: 20),

                      pw.Row(
                        children:[
                          pw.Paragraph(
                              text: 'إلي : ',
                              style: textStyle.copyWith(font: arabicFont),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                          pw.Paragraph(
                              text: to.isNotEmpty || to !=null
                                  ? to
                                  :' -----------------------------',
                              style: textStyle.copyWith(font: englishFont),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero
                          ),
                        ]
                      )
                    ]
                ),
                pw.Paragraph(
                  text: payment.isNotEmpty || payment!=null ? "حق الإيجار : ${payment.split(" ")[1]} درهم " :'حق الإيجار : -----------------------------------------------',
                    style: textStyle.copyWith(font: arabicFont),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero
                ),
                pw.Paragraph(
                  text: paymentStyle.isNotEmpty || paymentStyle!=null ? "أقساط الدفع : ${paymentStyle}" :'أقساط الدفع : -----------------------------------------------',
                    style: textStyle.copyWith(font: arabicFont),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero
                ),
                pw.SizedBox(height: 6),
                pw.Text("الشروط المتفق عليها كما يلي",
                  style: pw.TextStyle(fontSize: 18,font: arabicFontBold),
                ),
                pw.SizedBox(width: 230,
                  child:  pw.Divider(thickness: .5,color: PdfColors.black),),
                pw.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                    [
                                pw.Paragraph(
                                    text: "1- يتعهد المستأجر أن لا ينقل موضوع الإيجار الي أحد غيره بأي عنوان كان.",
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                  style: textStyle.copyWith(font: arabicFont),
                                ),
                                pw.Paragraph(
                                    text: "2- يكون تجديد موضوع الإيجار باختيار المؤجر واذا لم يجب المستأجر علي الطلب التجديد فسيكون ملزما بالإيجار الذي طلبه الؤجر منه.",
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                  style: textStyle.copyWith(font: arabicFont),
                                ),
                                pw.Paragraph(
                                    text: "3- تعتبر هذه الوثيقة قائمة الي انتهاء المدة المقررة وتسقط من الاعتبار حال انتهاء هذه المده.",
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                  style: textStyle.copyWith(font: arabicFont),
                                ),
                                pw.Paragraph(
                                    text: "4- في حالة الاخلاء يتعهد المستأجر ويلتزم ان لا يزيل أي شئ ثبته في الجار مثل مد الاسلاك الكهربائية وانابيب الماء وجميع الادوات الصحية وغيرها التي تسبب اضرار للجدار وتعتبر هذه الشروط نافذة المفعول.",
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                  style: textStyle.copyWith(font: arabicFont),
                                ),
                      pw.Paragraph(
                          text: "5- إذا خالف المسأجر احد الشروط المسجله ضمن هذه الوثيقه فمن حق المؤجر إخراج المستأجر من ملكه فورا وتسقط حقوق المستأجر من الاعتبار ولاله حق في ان يتمسك بشروط هذه الوثيقة.",
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                        style: textStyle.copyWith(font: arabicFont),
                      ),
                      pw.Paragraph(
                          text: "6- في حالة غياب المستأجر عن البلد بعد انتهاء مد الايجار أو مغادرتة منها بدون رضي المالك أو في حالة عدم تسديد المتبقي علية من الايجار فللمالك الحق برفه شكواه الي المحكمة الشرعيه في فتح المحل وتسليمة بعد ما حصر فيه وتسديد ما علي المستاجر من الديون للمالك",
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                        style: textStyle.copyWith(font: arabicFont),
                      ),


                    ]
                ),
                pw.SizedBox(height: 4),
                pw.RichText(text: TextSpan(children: [
                  TextSpan(
                    text: 'الملاحظات : ',
                    style: pw.TextStyle(fontSize: 16,font: arabicFont),
                  ),
                  TextSpan(
                    text: notes.isNotEmpty || notes !=null || notes !=' '
                        ?"$notes"
                        :'-----------------------------------------------------------------',
                    style: pw.TextStyle(fontSize: 14,font: PaymentHelper.containsEnglish(notes) ? englishFont:arabicFont),)


                ])),
                pw.Expanded(
                  child: pw.Align(
                    alignment: Alignment.bottomCenter,
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(
                              children: [
                                pw.Paragraph(
                                  text: 'توقيع المؤجر',
                                  style: textStyle.copyWith(font: arabicFont,fontSize: 16),
                                ),
                                pw.Stack(
                                    children: [
                                      Container(
                                          height: 60,
                                          width: 160,
                                          decoration: BoxDecoration(
                                              color: PdfColors.grey100
                                          ),
                                          child: isOwner ? pw.Padding(
                                              padding: EdgeInsets.all(8),
                                              child: pw.Center(
                                                child: signature.watch(signatureProvider).data!.isNotEmpty || signature.watch(signatureProvider).data! !=null
                                                    ? pw.Image(pw.MemoryImage(signature.watch(signatureProvider).data!),width: 200,)
                                                    :SizedBox(),
                                              )
                                          ):pw.SizedBox()
                                      )
                                    ]
                                ),
                              ]
                          ),

                          Column(
                              children: [
                                pw.Paragraph(
                                  text: 'توقيع المستأجر',
                                  style: textStyle.copyWith(font: arabicFont,fontSize: 16),
                                ),
                                pw.Stack(
                                    children: [
                                      Container(
                                          height: 60,
                                          width: 160,
                                          decoration: BoxDecoration(
                                              color: PdfColors.grey100
                                          ),
                                          child: !isOwner? pw.Padding(
                                              padding: EdgeInsets.all(8),
                                              child: pw.Center(
                                                child: signature.watch(signatureProvider).data!.isNotEmpty || signature.watch(signatureProvider).data! !=null
                                                    ? pw.Image(pw.MemoryImage(signature.watch(signatureProvider).data!),width: 200,)
                                                    :SizedBox(),
                                              )
                                          ): pw.Center(child:  pw.Padding(
                                              padding: EdgeInsets.all(8),
                                              child: pw.Image(pw.MemoryImage(renterSignature),width: 200,fit: BoxFit.contain)
                                          ))
                                      )
                                    ]
                                ),
                              ]
                          )

                        ]
                    ),
                  )
                )



                // Add more contract details as needed
              ],
            )
          );
        },
      ),

    );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
