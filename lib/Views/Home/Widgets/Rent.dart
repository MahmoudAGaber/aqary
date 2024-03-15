

import 'package:aqary/Views/Home/Widgets/SignaturePad.dart';
import 'package:aqary/Views/PdfViewer.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/utill/FileHandleApi.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../PdfGenerator.dart';
import '../../base/custom_app_bar.dart';
import 'EstateDetails.dart';


enum PaymentsSystem { monthly, annually, Semi_annually, Quarterly }

class Rent extends StatefulWidget {
  const Rent({super.key});

  @override
  State<Rent> createState() => _RentState();
}

class _RentState extends State<Rent> {
  PaymentsSystem? _payments = PaymentsSystem.annually;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Change primary color
            colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor,surface: Colors.white,surfaceTint: Colors.white),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          ), child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "استأجر الان",
        isCenter: true,
        isBackButtonExist: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 112,
                child: Card(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails()));

                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            "assets/images/estate1.png",
                            width: 154,
                            height: 122,
                            fit: BoxFit.cover ,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("شقه للايجار في الشامخه", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                Text("1", style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                SizedBox(width: 4,),
                                SvgPicture.asset("assets/images/bathroom.svg",color: Colors.grey,height: 16,),
                                SizedBox(width: Dimensions.paddingSizeDefault,),
                                Text("2", style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                SizedBox(width: 4,),
                                SvgPicture.asset("assets/images/bed.svg",color: Colors.grey,height: 16,),

                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: Dimensions.paddingSizeExtraSmall,
                                ),
                                Text(
                                  "الشامخه, أبوظبي",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 10),
                                ),
                              ],
                            ),
                            Text("30,000 درهم / سنويا", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Theme.of(context).primaryColor),),



                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text("المأجر",style: Theme.of(context).textTheme.titleLarge!),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        TextFormField(
                          //  controller: searchController,
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Color(0xFFF9FAFA),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              hintText: "اسم مأجر العقار",
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF9FAFA),
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor
                                  )
                              )
                          ),
                          onTap: (){

                          },
                          onChanged: (value){

                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.paddingSizeSmall,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text("المستأجر",style: Theme.of(context).textTheme.titleLarge!),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        TextFormField(
                          //  controller: searchController,
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Color(0xFFF9FAFA),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              hintText: "اسم المستأجر للعقار",
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF9FAFA),
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor
                                  )
                              )
                          ),
                          onTap: (){

                          },
                          onChanged: (value){

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text("مده الإيجار",style: Theme.of(context).textTheme.titleLarge!),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        TextFormField(
                          //  controller: searchController,
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Color(0xFFF9FAFA),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              hintText: "من",
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 14,height: 2.5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF9FAFA),
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor
                                  )
                              ),
                            prefixIcon: IconButton(
                                onPressed: (){
                                  _selectDate(context);
                                },
                                icon:Icon(Icons.calendar_month_outlined,color: Colors.black,size: 20,)),
                          ),
                          onTap: (){

                          },
                          onChanged: (value){

                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.paddingSizeSmall,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text("",style: Theme.of(context).textTheme.titleLarge!),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        TextFormField(
                          //  controller: searchController,
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Color(0xFFF9FAFA),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              hintText: "إلي",
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 14,height: 2.5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF9FAFA),
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor
                                  )
                              ),
                            prefixIcon: IconButton(
                                onPressed: (){
                                  _selectDate(context);
                                },
                                icon:Icon(Icons.calendar_month_outlined,color: Colors.black,size: 20,)),


                          ),
                          onTap: (){

                          },
                          onChanged: (value){

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text("نظام الدفعات",style: Theme.of(context).textTheme.titleLarge!),
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall,),
                  Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      alignment: WrapAlignment.center,
                      children: List.generate(paymentsSystemTxt.length, (index) => paymentWidget(index))
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              TextFormField(
                //  controller: searchController,
                textDirection: TextDirection.rtl,
                cursorColor: Colors.grey,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Color(0xFFF9FAFA),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    hintText: "ادخل السعر السنوي للعقار الخاص بك",
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFFF9FAFA),
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor
                        )
                    )
                ),
                onTap: (){

                },
                onChanged: (value){

                },
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text("طريقه الدفع",style: Theme.of(context).textTheme.titleLarge!),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        Container(
                          height: 95,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9FAFA),
                              borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/cash.svg",),
                              SizedBox(height: Dimensions.paddingSizeSmall,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text("كاش",style: Theme.of(context).textTheme.bodyMedium!.copyWith()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text("",style: Theme.of(context).textTheme.titleLarge!),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        Container(
                          height: 95,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9FAFA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/bank.svg",color: Colors.black,),
                              SizedBox(height: Dimensions.paddingSizeSmall,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text("تحويل بنكي",style: Theme.of(context).textTheme.bodyMedium!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text("ملاحظات",style: Theme.of(context).textTheme.titleLarge!),
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall,),
                  TextFormField(
                    //  controller: searchController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Colors.grey,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Color(0xFFF9FAFA),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 6 ),
                        hintText: "اكتب ملاحظاتك هنا",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFFF9FAFA),
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor
                            )
                        )
                    ),
                    onTap: (){

                    },
                    onChanged: (value){

                    },
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 123,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Theme.of(context).primaryColor
                          )
                      ),
                      child: InkWell(
                        onTap: (){
                          PdfInvoiceApi.generate();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PdfViewer()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/file.png",height: 38,color: Theme.of(context).primaryColor,),
                            SizedBox(height: Dimensions.paddingSizeSmall,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text("معاينة العقد",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.paddingSizeDefault,),
                  Expanded(
                    child: Container(
                      height: 123,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Theme.of(context).primaryColor
                          )
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignaturePad()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/sing.svg",),
                            SizedBox(height: Dimensions.paddingSizeSmall,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text("توقيع عقد الإيجار",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              CustomButton(
                onPressed: (){

                },
                  buttonText: "إرسال",
                textColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                  )



            ],
          ),
        ),
      ),
    );
  }
  List<String> paymentsSystemTxt = [
    "سنوي",
    "نصف سنوي",
    "شهري",
    "ربع سنوي",
  ];

  Widget paymentWidget(index){
    return  SizedBox(
      width: MediaQuery.of(context).size.width*.45,
      child: ListTile(
        contentPadding: EdgeInsets.zero ,
        title:  Text(paymentsSystemTxt[index],style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xff677294))),
        leading: Radio<PaymentsSystem>(
          value: PaymentsSystem.values[index],
          groupValue: _payments,
          onChanged: (PaymentsSystem? value) {
            setState(() {
              _payments = value;
            });
          },
        ),
      ),
    );
  }
}
