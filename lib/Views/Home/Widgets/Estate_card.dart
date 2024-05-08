

import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/ViewModel/CategoryViewModel.dart';
import 'package:aqary/helper/date_converter.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Models/CategoryModel.dart';
import '../../../ViewModel/FavoritesViewModel.dart';
import '../../../ViewModel/RealStateViewModel.dart';
import 'EstateDetails.dart';

class EstateCard extends ConsumerStatefulWidget {
  List<RealStateModel>? properties;
  EstateCard({super.key, this.properties});

  @override
  ConsumerState<EstateCard> createState() => _EstateCardState();
}

class _EstateCardState extends ConsumerState<EstateCard> {
  @override
  Widget build(BuildContext context) {
    var property = ref.watch(RealStateGetOneProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height*.28,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.properties!.length,
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          itemBuilder: (context,index){
            var item = widget.properties![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: InkWell(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails(propertyId: item.id!,)));

                },
                child: Container(
                  width: 260,
                  child: Card(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              child: item.images.isEmpty
                                  ? SizedBox(
                                width: 232,
                                height: 144,)
                                  :Image.network(
                                "${item.images.first.path}",
                                width: 232,
                                height: 144,
                                fit: BoxFit.cover ,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${item.title}", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                                  SizedBox(height: 4,),
                                  Text("${DateConverter.numberFormat(item.yearPrice)} درهم / سنويا ", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Theme.of(context).primaryColor),),
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
                                        "${item.country}, ${item.city}",
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
                          bottom: 58,
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
                                ref.read(categoryProvider.notifier).addFavorite(widget.properties![index].id!,index);
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
