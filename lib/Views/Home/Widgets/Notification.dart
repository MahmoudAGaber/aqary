

import 'package:aqary/Models/NotificationModel.dart';
import 'package:aqary/Views/Home/Widgets/OwnerCTSignature.dart';
import 'package:aqary/Views/Home/Widgets/PaymentEstate.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:aqary/helper/date_converter.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../ViewModel/NotificationViewModel.dart';

class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key});

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {

  bool noData = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(NotificationProvider.notifier).getNotifications();

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var notification = ref.watch(NotificationProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "الإشعارات",
        isCenter: true,
        isBackButtonExist: true,
      ),
      body: notification.handelState<NotificationModel>(
          onLoading: (state) => Center(child: SizedBox(height:30,width:30,child: CircularProgressIndicator(color: Colors.grey,))),
        onSuccess: (state) => SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 18,right: 18,top: Dimensions.paddingSizeDefault),
                  //   child: Text("اليوم",
                  //     style: Theme.of(context).textTheme.titleLarge,),
                  // ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),
                  ListView.builder(
                    itemCount: notification.data!.length,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                      return Column(children: List.of(dailyNotification(index)),);

                  }),
                  //Column(children: List.generate(length, (index) => null),)
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 18,right: 18,top: Dimensions.paddingSizeDefault),
              //       child: Text("الامس",
              //         style: Theme.of(context).textTheme.titleLarge,),
              //     ),
              //     SizedBox(height: Dimensions.paddingSizeDefault,),
              //     Column(children: List.of(dailyNotification("1"))),
              //     //Column(children: List.generate(length, (index) => null),)
              //   ],
              // )
            ],
          ),
        ),
        onFailure: (state) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Column(
                children: [
                  SizedBox(
                    height: 185,
                    width: 185,
                    child: Stack(
                      children: [
                        SvgPicture.asset("assets/images/Ellipse2.svg",colorFilter: ColorFilter.linearToSrgbGamma(),),
                        Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),)),
                        Center(child: SvgPicture.asset("assets/images/Notification.svg",)),
                        Positioned(
                          top: 48,
                          right: 50,
                          child: Text('Z',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeExtraLarge,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Positioned(
                          top: 65,
                          right: 65,
                          child: Text('Z',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("لا يوجد إشعارات",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),overflow: TextOverflow.clip,),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      Text("لا يوجد إشعارات في الوقت الحالي، سيظهر إشعارك هنا",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey,overflow: TextOverflow.clip,))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }


  Widget exclusiveOffers(){
    return  Container(
      height: 100,
      color: Color(0x38C8E5A4),
      child: Padding(
        padding: const EdgeInsets.only(left: 18,right: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: Stack(
                children: [
                  Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),)),
                  Center(child: SvgPicture.asset("assets/images/bxs_offer.svg",height: 24,width: 24,)),

                ],
              ),
            ),
            SizedBox(width: Dimensions.paddingSizeSmall,),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('عروض حصرية',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14)),
                      Text('1س',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                    ],
                  ),

                  Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص هذا النص هو مثال لنص",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey,overflow: TextOverflow.clip,))


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bookedSuccess(NotificationModel notificationItem){
    return  Container(
      height: 100,
      color: !notificationItem.isRead ? Color(0x38C8E5A4): null,
      child: Padding(
        padding: const EdgeInsets.only(left: 18,right: 18),
        child: Row(
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: Stack(
                children: [
                  Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Color(0xff03FC8E5A4),borderRadius: BorderRadius.circular(50)),)),
                  Center(child: SvgPicture.asset("assets/images/tabler_calendar-up.svg",height: 24,width: 24,)),

                ],
              ),
            ),
            SizedBox(width: Dimensions.paddingSizeSmall,),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(notificationItem.title,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14)),
                      Text(DateConverter.timeAgoSinceDate(DateTime.parse(notificationItem.createdAt),),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),textAlign: TextAlign.left,),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      if(notificationItem.title.contains("request")){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> OwnerCTSignature(contractId: notificationItem.contract,)));

                      }else if(notificationItem.title.contains("accepted")){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentEstate(contractId: notificationItem.contract,)));
                      }
                    },
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: notificationItem.body,style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey) ),
                              TextSpan(text: notificationItem.title.contains("request") ?" اذهب الي صفحه التوقيع " :" اذهب الي صفحه الدفع ",style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor),),
                              TextSpan(text: notificationItem.title.contains("request") ?"لإتمام تأجير العقار" :"الآن ",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey))
                    ])),
                  ),
                  Text("  ",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey,overflow: TextOverflow.clip,))


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget estateFavSell(){
    return  Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 18,right: 18),
        child: Row(
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: Stack(
                children: [
                  Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Color(0xff03FC8E5A4),borderRadius: BorderRadius.circular(50)),)),
                  Center(child: SvgPicture.asset("assets/images/solar_star-linear.svg",height: 24,width: 24,)),

                ],
              ),
            ),
            SizedBox(width: Dimensions.paddingSizeSmall,),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('لقد تم بيع إعلانك المفضل',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14)),
                      Text('1س',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                    ],
                  ),

                  Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص هذا النص هو مثال لنص",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey,overflow: TextOverflow.clip,))

                ],
              ),
            )
          ],
        ),
      ),
    );
  }



  List<Widget> dailyNotification (index){
    List<Widget> items = [];
    var notification = ref.watch(NotificationProvider);

    if(notification.data![index].type == 'reservation'){
      items.add(bookedSuccess(notification.data![index]));

    }

    return items;
  }





}
