

import 'package:aqary/Views/Home/Widgets/PaymentEstate.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  bool noData = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "الإشعارات",
        isCenter: true,
        isBackButtonExist: true,
      ),
      body: noData?
      SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18,right: 18,top: Dimensions.paddingSizeDefault),
                    child: Text("اليوم",
                      style: Theme.of(context).textTheme.titleLarge,),
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),
                  Column(children: List.of(dailyNotification("2"))),
                  //Column(children: List.generate(length, (index) => null),)
                ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18,right: 18,top: Dimensions.paddingSizeDefault),
                  child: Text("الامس",
                    style: Theme.of(context).textTheme.titleLarge,),
                ),
                SizedBox(height: Dimensions.paddingSizeDefault,),
                Column(children: List.of(dailyNotification("1"))),
                //Column(children: List.generate(length, (index) => null),)
              ],
            )
          ],
        ),
      )
          :Row(
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

  Widget bookedSuccess(){
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
                      Text('تم حجز العقار بنجاح',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14)),
                      Text('1س',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey)),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentEstate()));

                    },
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: "تم الموافقه علي تأجير العقار بنجاح من قبل المأجر انتقل الي ",style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey) ),
                              TextSpan(text: "صفحه الدفع ",style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor),),
                              TextSpan(text: "لإتمام تأجير العقار",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey))
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



  List<Widget> dailyNotification (String type){
    List<Widget> items = [];

    if(type == '1'){
      items.add(estateFavSell());
      items.add(exclusiveOffers());
      items.add(exclusiveOffers());
      items.add(exclusiveOffers());

    }
    else if(type == '2'){
      items.add(estateFavSell());
      items.add(exclusiveOffers());
      items.add(bookedSuccess());
      items.add(exclusiveOffers());
    }
    else if(type == '3'){
      items.add(estateFavSell());
    }

    return items;
  }





}
