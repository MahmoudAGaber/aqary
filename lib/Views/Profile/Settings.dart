import 'package:aqary/Views/HomePage.dart';
import 'package:aqary/Views/Login.dart';
import 'package:aqary/Views/Profile/AddEstateOwner.dart';
import 'package:aqary/Views/Profile/AddHousingOffical.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ViewModel/NotificationViewModel.dart';
import '../../ViewModel/UserViewModel.dart';
import '../../helper/Authentication.dart';
import '../base/custom_app_bar.dart';

class Settings extends ConsumerStatefulWidget {

   Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(UserProvider.notifier).getUserInfo().then((value){
        ref.read(enableNotificationProvider.notifier).state = value!.notificationEnabled;
      });


    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(UserProvider).state;
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
    if( index ==0 || index == 1 || index == 2 ){
      return Icon(Icons.arrow_forward_ios,size: 18,);
    }
    return SizedBox();
  }

  Widget settingsWidget(index){
    return InkWell(
      onTap: (){
        if(index == 0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage(page: 2)));
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
            index == 3
                ?  Transform.scale(
                   scale: .85,
                  child: Switch(
                    value: ref.watch(enableNotificationProvider),
                    onChanged: (bool value) {
                  ref.read(enableNotificationProvider.notifier).state = ! ref.read(enableNotificationProvider.notifier).state;
                  var enableNoti = ref.watch(enableNotificationProvider);
                  print(enableNoti);
                  Map<String ,dynamic> data = {
                    "notification": enableNoti.toString(),
                  };
                  ref.read(UserProvider.notifier).updateUser(data);
                  },
                    activeColor: Colors.white,
                    activeTrackColor: Theme.of(context).primaryColor,
                  ),
                ):
            index == 4
                ? Text("العربية")
                :settingsActions(index)
          ],
        ),
      ),
    );
  }
}
