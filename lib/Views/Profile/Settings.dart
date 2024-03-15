import 'package:aqary/Views/Aqary.dart';
import 'package:aqary/Views/Login.dart';
import 'package:aqary/Views/Profile/AddEstateOwner.dart';
import 'package:aqary/Views/Profile/AddHousingOffical.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helper/Authentication.dart';
import '../base/custom_app_bar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "الإعدادات",
        isBackButtonExist: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(settingStr.length, (index) => settingsWidget(index)),
        ),
      ),
    );
  }
  List<String> settingStr = [
    "عقاراتي",
    "إضافه مسئول سكن ( وسيط )",
    "إضافه مالك عقار",
    "إرسال الاشعارات",
    "اللغه",
    "إلغاء الحساب",
    "تسجيل الخروج",
  ];
  List<String> settingsIcons = [
   "assets/images/home2.svg",
   "assets/images/edit-3.svg",
   "assets/images/edit-3.svg",
   "assets/images/Notification.svg",
    "assets/images/book.svg",
    "assets/images/remove.png",
    "assets/images/log-out.svg",
  ];

  Widget settingsActions(index){
    if( index ==0 || index == 1 || index == 2 || index == 4){
      return Icon(Icons.arrow_forward_ios,size: 18,);
    }
    return SizedBox();
  }

  Widget settingsWidget(index){
    return InkWell(
      onTap: (){
        if(index == 0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Aqary()));
        }
        if(index == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddHousingOffical()));
        }
        if(index == 2){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEstateOwner()));
        }
        if(index == 3){
        }
        if(index == 4){
        }
        if(index == 6){
          AuthService().signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                index == 5 ?Image.asset(settingsIcons[index],height: 22,):
                SvgPicture.asset(settingsIcons[index],height: 25,color: index!=5 ? Colors.black : Colors.red,),
                SizedBox(width: Dimensions.paddingSizeDefault,),
                Text(settingStr[index], style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)),
              ],
            ),
            settingsActions(index)
          ],
        ),
      ),
    );
  }
}
