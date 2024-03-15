import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import '../utill/FileHandleApi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = pw.Document();

    final iconImage =
    (await rootBundle.load('assets/images/file.png')).buffer.asUint8List();

    var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/NotoSansArabic-Regular.ttf"));
   var arabicFontBold = Font.ttf(await rootBundle.load("assets/fonts/NotoSansArabic-Bold.ttf"));

    TextStyle textStyle = pw.TextStyle(fontSize: 15);
    final tableHeaders = [
      'Description',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total',
    ];

    final tableData = [
      [
        'Coffee',
        '7',
        '\$ 5',
        '1 %',
        '\$ 35',
      ],
      [
        'Blue Berries',
        '5',
        '\$ 10',
        '2 %',
        '\$ 50',
      ],
      [
        'Water',
        '1',
        '\$ 3',
        '1.5 %',
        '\$ 3',
      ],
      [
        'Apple',
        '6',
        '\$ 8',
        '2 %',
        '\$ 48',
      ],
      [
        'Lunch',
        '3',
        '\$ 90',
        '12 %',
        '\$ 270',
      ],
      [
        'Drinks',
        '2',
        '\$ 15',
        '0.5 %',
        '\$ 30',
      ],
      [
        'Lemon',
        '4',
        '\$ 7',
        '0.5 %',
        '\$ 28',
      ],
    ];

    pdf.addPage(
      pw.Page(
        theme: ThemeData.withFont(
          base: arabicFont,
        ),
        build: (context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text("وثــــيــــقة إيــــجــــار",
                  style: pw.TextStyle(fontSize: 20,font: arabicFontBold,fontStyle: pw.FontStyle.italic),
                ),

                SizedBox(width: 200,
               child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 12),
                child:  pw.Divider(thickness: .5))),

                pw.Paragraph(
                  text: 'التاريخ : -----------------------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'الرقم : ------------------------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'المؤجر : -----------------------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'المستأجر : ---------------------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'موضوع الإيجار :-------------------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'مدة الإيجار : ------------------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'من : ------------------------------  إلي : -------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'حق الإيجار : -----------------------------------------------',
                  style: textStyle,
                ),
                pw.Paragraph(
                  text: 'أقساط الدفع : -----------------------------------------------',
                  style: textStyle,
                ),
                pw.SizedBox(height: 6),
                pw.Text("الشروط المتفق عليها كما يلي",
                  style: pw.TextStyle(fontSize: 18,font: arabicFontBold),
                ),
                pw.SizedBox(width: 230,
                  child:  pw.Divider(thickness: .5),),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Paragraph(
                          text: 'توقيع المؤجر',
                          style: textStyle,
                        ),
                        pw.Stack(
                            children: [
                              Container(
                                  height: 80,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: PdfColors.grey100
                                  )
                              )
                            ]
                        ),
                      ]
                    ),

                    Column(
                      children: [
                        pw.Paragraph(
                          text: 'توقيع المستأجر',
                          style: textStyle,
                        ),
                        pw.Stack(
                            children: [
                              Container(
                                  height: 80,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: PdfColors.grey100
                                  )
                              )
                            ]
                        ),
                      ]
                    )

                  ]
                ),

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
