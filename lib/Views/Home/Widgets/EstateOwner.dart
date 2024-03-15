

import 'package:aqary/Views/Home/Widgets/AddEstate/AddEstateToManage.dart';
import 'package:aqary/Views/Home/Widgets/RentContract/RentContract.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../utill/dimensions.dart';
import 'AddEstate/AddEstate.dart';

class EstateOwner extends StatelessWidget {
   EstateOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "هل أنت مالك عقار ؟"),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(itemText.length, (index) => item(context,index))),
      )
    );
  }

  List<String> itemText = [
  "إضافه عقار لإدارته",
    "الاعلان عن عقار للتأجير",
    "إنشاء عقد إيجار",
  ];

  Widget item (context, index){
    return Column(
      children: [
        SizedBox(height: Dimensions.paddingSizeLarge,),
        SizedBox(
          width: MediaQuery.of(context).size.width*.9,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*.8,
                height: 71,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0x778BC83D)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,)
                  ],),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Text(itemText[index],style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),),
                    )),
              ),
              Positioned(
                top: 19,
                bottom: 19,
                left: 30,
                child: InkWell(
                  onTap: (){
                    if(index == 0){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEstateToManage()));
                    }
                    if(index == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEstate()));
                    }
                    if(index == 2){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RentContract()));
                    }
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.add,color: Colors.white,size: 25,),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
