

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utill/dimensions.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import 'ContractDetails.dart';

class RentContract extends StatefulWidget {
  const RentContract({super.key});

  @override
  State<RentContract> createState() => _RentContractState();
}

class _RentContractState extends State<RentContract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "إنشاء عقد إيجار",
        isCenter: true,
        isBackButtonExist: true,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: CustomButton(
              buttonText: "التالي",
              textColor: Colors.white,
              height: 50,
              borderRadius: 12,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ContractDetails()));
              }
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("اختر عقارا",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),),
                      Text(" لإنشاء عقد إيجار خاص به",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),),
                      SizedBox(height: Dimensions.paddingSizeLarge,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.75,
                        child: ListView(
                          children: [
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

                      )
                    ],
                  ),

                ])
        )
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
}
