

import 'package:aqary/Views/Profile/EditProfile.dart';
import 'package:aqary/Views/Profile/EditRealState.dart';
import 'package:aqary/Views/Profile/Settings.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../base/custom_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "الصفحه الشخصيه",
        isBackButtonExist: false,
        leadingView: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
          },
            child: Icon(Icons.settings,color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,width: 100,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50)
                              ),
                             ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
                                  },
                                  child: Container(
                                    height: 30,width: 30,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                      child: Icon(Icons.edit,color: Colors.white,size: 18,))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.paddingSizeDefault,),
                      Text("احمد مصطفي", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "+1 234 567 8911",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 10),
                            overflow: TextOverflow.clip,
                            softWrap: true,
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.paddingSizeLarge,),
                      Container(
                        width: MediaQuery.of(context).size.width*.9,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF5F4F7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),

                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF5F4F8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                                    child: Text(
                                      'العقارات المتوفره',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black)
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Container(
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                                    child: Text(
                                      'العقارات المؤجره',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black)
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Container(
                                  decoration: ShapeDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                                    child: Text(
                                      'الكل',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                      ),
                      SizedBox(height: Dimensions.paddingSizeDefault,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*.9,
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // number of items in each row
                                mainAxisSpacing: 2.0, // spacing between rows
                                crossAxisSpacing: 2.0, // spacing between columns
                                mainAxisExtent: 270
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
                                    Card(
                                      color: Colors.white,
                                      elevation: 2,
                                      surfaceTintColor: Colors.white,
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
                                                  height: 190,
                                                  width: 220,
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
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 18,
                                      left: 18,
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Stack(
                                          children: [
                                            Center(child: Container(width: 25,height:25,
                                              decoration: BoxDecoration(color:  Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(50)),)),
                                            Center(child: InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditEstate()));
                                              },
                                                child: Icon(Icons.edit,color: Colors.white,size: 14,)),),

                                          ],
                                        ),),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
