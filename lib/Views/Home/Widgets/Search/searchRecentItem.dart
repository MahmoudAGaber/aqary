

import 'package:aqary/ViewModel/UserViewModel.dart';
import 'package:aqary/Views/Home/Widgets/EstateDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Models/RealStateModel.dart';
import '../../../../ViewModel/FavoritesViewModel.dart';
import '../../../../ViewModel/SearchViewModel.dart';
import '../../../../helper/date_converter.dart';
import '../../../../utill/dimensions.dart';

class SearcgRecentItem extends ConsumerStatefulWidget {
  //List<RealStateModel> realStateModel;
   SearcgRecentItem({super.key});

  @override
  ConsumerState<SearcgRecentItem> createState() => _SearcgRecentItemState();
}

class _SearcgRecentItemState extends ConsumerState<SearcgRecentItem> {
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(UserProvider);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisExtent: 235,
            mainAxisSpacing: 4.0, // spacing between rows
            crossAxisSpacing: 4.0, // spacing between columns
          ),
          shrinkWrap: true,
          itemCount: user.data!.recentlySeen.length,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          itemBuilder: (context,index){
            var item = user.data!.recentlySeen[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: SizedBox(
                width: 260,
                child: Card(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                       // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EstateDetails(propertyId: item.id!)));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              child:  item.images.isNotEmpty
                                  ?Image.network(
                                item.images.first.path,
                                width: 232,
                                height: 144,
                                fit: BoxFit.cover ,
                              ):SizedBox(
                                width: 232,
                                height: 144,),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                                SizedBox(height: 4,),
                                Text("${DateConverter.numberFormat(item.yearPrice)} درهم / سنويا", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Theme.of(context).primaryColor),),
                                SizedBox(height: 4,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall,
                                    ),
                                    Text(
                                      "${item.city}, ${item.country}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 10),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 65,
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
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: (){
                              ref.read(UserProvider.notifier).addFavorite(item.id!,'recent');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SvgPicture.asset("assets/images/heart2.svg",color: item.isFavorite? Colors.red : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  List<String> searchImage =[
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",

  ];
}
