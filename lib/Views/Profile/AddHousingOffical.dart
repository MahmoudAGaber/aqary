
import 'package:aqary/Views/Profile/Settings.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utill/dimensions.dart';
import '../base/custom_button.dart';
import '../base/custom_dialog.dart';

class AddHousingOffical extends StatefulWidget {
  const AddHousingOffical({super.key});

  @override
  State<AddHousingOffical> createState() => _AddHousingOfficalState();
}

class _AddHousingOfficalState extends State<AddHousingOffical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "إضافة مسئول سكن",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text("بيانات الوسيط",style: Theme.of(context).textTheme.titleLarge!),
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
                        hintText: "الاسم بالكامل",
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
                        hintText: "رقم الهاتف",
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
              SizedBox(height: Dimensions.paddingSizeExtraLarge,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    Text("تحديد العقار",style: Theme.of(context).textTheme.titleLarge!),
                  ],
                ),

              ),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 2.0, // spacing between rows
                      crossAxisSpacing: 2.0, // spacing between columns
                      mainAxisExtent: 250
                  ),
                  shrinkWrap: true,
                  itemCount: 6,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 260,
                            child: Card(
                              color: index == 0 ? Theme.of(context).primaryColor:Colors.white,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){},
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Image.asset(
                                          searchImage[index],
                                          height: 169,
                                          fit: BoxFit.cover ,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(" شقه للايجار في الشامخه",
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: index ==0 ? Colors.white : Colors.black)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 18,
                            right: 18,
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Stack(
                                children: [
                                  Center(child: Container(width: 25,height:25,
                                    decoration: BoxDecoration(color: index == 0 ? Theme.of(context).primaryColor: Colors.grey,borderRadius: BorderRadius.circular(50)),)),
                                  Center(child: Text("✓",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),)),

                                ],
                              ),),
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
      floatingActionButton:Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: CustomButton(
              buttonText: "إضافة",
              height: 48,
              borderRadius: 12,
              textColor: Colors.white,
              onPressed: (){
                showAnimatedDialog(
                    context, dismissible: false, housingOfficalAdded()
                );
              }
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  List<String> searchImage =[
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",

  ];

  Widget housingOfficalAdded(){
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.zero,
      child: Builder(
        builder: (BuildContext dialogContext){
          return  Container(
            height: MediaQuery.of(dialogContext).size.height*.38,
            width: MediaQuery.of(dialogContext).size.width*.9,
            child: Column(
              children: [
                SizedBox(
                  height: 185,
                  width: 185,
                  child: Stack(
                    children: [
                      SvgPicture.asset("assets/images/Ellipse2.svg",colorFilter: ColorFilter.linearToSrgbGamma(),),
                      Center(child: SvgPicture.asset("assets/images/Ellipse2.svg",height: 150,width: 150,)),
                      Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Theme.of(dialogContext).primaryColor,borderRadius: BorderRadius.circular(50)),)),
                      Center(child: Text("✓",style: Theme.of(dialogContext).textTheme.titleLarge!.copyWith(fontSize: 22,color: Colors.white),)),

                    ],
                  ),),
                Text('تم إضافة الوسيط بنجاح !',
                  textAlign: TextAlign.center,
                  style: Theme.of(dialogContext).textTheme.titleLarge!.copyWith(fontSize: 20),),
                SizedBox(height: Dimensions.paddingSizeLarge,),
                CustomButton(
                    buttonText: "تم",
                    height: 50,
                    width: 200,
                    textColor: Colors.white,
                    borderRadius: 12,
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext? context) {
                        if (context != null) {
                          return Settings();
                        } else {
                          // Handle the case where context is null
                          return Container(); // or any other fallback UI
                        }
                      }));
                    }
                ),
              ],
            ),);
        },
      ),
    );
  }
}
