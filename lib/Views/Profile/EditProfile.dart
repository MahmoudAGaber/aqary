

import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/Views/base/custom_text_field.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';

import '../base/custom_app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "تعديل الصفحه الشخصيه",
        isBackButtonExist: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: Icon(Icons.add,color: Colors.white,size: 18,))),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeDefault,),
                CustomTextField(
                  hintText: "احمد مصطفي",
                  isPadding: true,
                  fillColor: Colors.grey[100],
                  isShowBorder: false,
                )
              ],
            ),
            CustomButton(
                buttonText: "حفظ التغييرات",
                textColor: Colors.white,
                onPressed: (){},
            ),
          ],
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
