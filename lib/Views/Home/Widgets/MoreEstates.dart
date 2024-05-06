


import 'package:aqary/ViewModel/RealStateViewModel.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/helper/ShimmerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utill/dimensions.dart';
import 'EstateDetails.dart';
import 'MoreEstatesFilter.dart';
import 'Search/filterBS.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class MoreEstates extends ConsumerStatefulWidget {
  const MoreEstates({super.key});

  @override
  ConsumerState<MoreEstates> createState() => _MoreEstatesState();
}

class _MoreEstatesState extends ConsumerState<MoreEstates> {

  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

        ref.read(RealStateProvider.notifier).getRealStates(page: page, limit: 10);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   var proprities =  ref.watch(RealStateProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'عقارات',
        isBackButtonExist: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
        child: proprities.isNotEmpty
            ?Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       // InkWell(
            //       //   onTap: (){
            //       //     ref.read(RealStateProvider.notifier).state = [];
            //       //     ref.read(RealStateProvider.notifier).getRealStates(page: page, limit: 10);
            //       //   },
            //       //   child: Padding(
            //       //     padding: const EdgeInsets.all(2.0),
            //       //     child: Icon(
            //       //      Icons.clear,
            //       //       color: Theme.of(context).primaryColor,
            //       //     ),
            //       //   ),
            //       // ),
            //       // SizedBox(width: 8,),
            //       // InkWell(
            //       //     onTap: () {
            //       //       MoreEstateFilter().estatesFilter(context);
            //       //     },
            //       //     child: SvgPicture.asset(
            //       //         'assets/images/filter.svg'))
            //     ],
            //   ),
            // ),
           NotificationListener(
             onNotification: (notification) {
               if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                 page++;
                 ref.read(loadingMoreProvider.notifier).state = true;
                 ref.read(RealStateProvider.notifier).getRealStates(page: page,limit: 10).then((value){
                   ref.read(loadingMoreProvider.notifier).state = false;

                 });
               }
               return false;
             },
             child: Expanded(
               child: ListView.builder(
                 padding: EdgeInsets.zero,
                 shrinkWrap: true,
                 itemCount: proprities != null ? proprities.length + 1 : 0,
                 scrollDirection: Axis.vertical,
                 physics: ScrollPhysics(),
                 itemBuilder: (context, index) {
                   if (index < proprities.length) {
                     var item = proprities[index];
                     return Padding(
                       padding: const EdgeInsets.symmetric(vertical: 2),
                       child: InkWell(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => EstateDetails(propertyId: item.id!),
                             ),
                           );
                         },
                         child: Container(
                           height: 112,
                           child: Card(
                             color: Colors.white,
                             child: Stack(
                               children: [
                                 Row(
                                   children: [
                                     item.images.isEmpty
                                         ? SizedBox()
                                         : ClipRRect(
                                       borderRadius: BorderRadius.all(Radius.circular(10)),
                                       child: Image.network(
                                         item.images.first.path,
                                         width: 154,
                                         height: 122,
                                         fit: BoxFit.cover,
                                       ),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             item.title,
                                             style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                                           ),
                                           Row(
                                             children: [
                                               Text(item.bathroomsCount.toString(),
                                                   style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                               SizedBox(width: 4,),
                                               SvgPicture.asset("assets/images/bathroom.svg", color: Colors.grey, height: 16,),
                                               SizedBox(width: Dimensions.paddingSizeDefault,),
                                               Text(item.bedroomsCount.toString(), style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                               SizedBox(width: 4,),
                                               SvgPicture.asset("assets/images/bed.svg", color: Colors.grey, height: 16,),
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               Icon(
                                                 Icons.location_on,
                                                 color: Colors.grey,
                                                 size: 14,
                                               ),
                                               SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                               Text(
                                                 "${item.city}, ${item.country}",
                                                 style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                                               ),
                                             ],
                                           ),
                                           Text(
                                             "${item.yearPrice} درهم / سنويا",
                                             style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, color: Theme.of(context).primaryColor),
                                           ),
                                         ],
                                       ),
                                     )
                                   ],
                                 ),
                                 Positioned(
                                   bottom: 10,
                                   left: 6,
                                   child: Container(
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(50),
                                       boxShadow: [
                                         BoxShadow(
                                           color: Color(0x19121212),
                                           blurRadius: 10,
                                           offset: Offset(4, 4),
                                           spreadRadius: 0,
                                         )
                                       ],
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: SvgPicture.asset("assets/images/heart2.svg"),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),
                     );
                   } else {
                     return ref.watch(loadingMoreProvider)
                         ?Container(
                       height: 50,
                       alignment: Alignment.center,
                       child: SpinKitThreeBounce(
                         color: Theme.of(context).primaryColor,
                         size: 25,
                       ),)
                         :SizedBox();
                   }
                 },
               ),
             ),
           )
          ],
        )
            :ShimmerList('List'),
      ),
    );
  }
}
