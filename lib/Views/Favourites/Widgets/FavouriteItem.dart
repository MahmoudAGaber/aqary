



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utill/dimensions.dart';
import '../../../Models/CategoryModel.dart';
import '../../../Models/RealStateModel.dart';
import '../../../ViewModel/CategoryViewModel.dart';
import '../../../ViewModel/FavoritesViewModel.dart';
import '../../Home/Widgets/EstateDetails.dart';

class FavouriteItem extends ConsumerWidget {
  List<RealStateModel>? properties;
  FavouriteItem({super.key,this.properties});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: properties!.length,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemBuilder: (context,index){
          var item = properties![index];
          return Dismissible(
            key: Key("unique_key"),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,

              ),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(CupertinoIcons.delete,color: Colors.white,size: 26,),
                  )),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Card(
                child: Stack(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails(propertyId: item.id!,)));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: item.images.isEmpty
                                ?SizedBox( width: 154, height: 107,)
                                :Image.network(
                              "${item.images.first.path}",
                              width: 154,
                              height: 107,
                              fit: BoxFit.cover ,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 2),
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${item.title}", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                                Row(
                                  children: [
                                    Text("${item.bathroomsCount}", style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                    SizedBox(width: 4,),
                                    SvgPicture.asset("assets/images/bathroom.svg",color: Colors.grey,height: 16,),
                                    SizedBox(width: Dimensions.paddingSizeDefault,),
                                    Text("${item.bedroomsCount}", style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                    SizedBox(width: 4,),
                                    SvgPicture.asset("assets/images/bed.svg",color: Colors.grey,height: 16,),

                                  ],
                                ),
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
                                ),
                                Text("${item.yearPrice} درهم / سنويا ", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Theme.of(context).primaryColor),),



                              ],
                            ),
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
                        child: InkWell(
                          onTap: (){
                            ref.read(favoritesProvider.notifier).addFavorite(properties![index].id!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset("assets/images/heart2.svg",color: item.isFavorite!? Colors.red : null,
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
        });
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
