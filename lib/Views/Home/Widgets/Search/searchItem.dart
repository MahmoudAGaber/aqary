

import 'package:aqary/ViewModel/SearchViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utill/dimensions.dart';
import '../EstateDetails.dart';

class SearchItem extends ConsumerStatefulWidget {
   SearchItem({super.key});

  @override
  ConsumerState<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends ConsumerState<SearchItem> {
  @override
  Widget build(BuildContext context) {
    var searchResults = ref.watch(SearchProvider);
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: searchResults.data!.length,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemBuilder: (context,index){
          var item = searchResults.data![index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails(propertyId: item.id!,)));

              },
              child: Container(
                height: 112,
                child: Card(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          item.images.isEmpty ? SizedBox():ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              item.images.first.path,
                              width: 154,
                              height: 122,
                              fit: BoxFit.cover ,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                                Row(
                                  children: [
                                    Text(item.bathroomsCount.toString(), style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                    SizedBox(width: 4,),
                                    SvgPicture.asset("assets/images/bathroom.svg",color: Colors.grey,height: 16,),
                                    SizedBox(width: Dimensions.paddingSizeDefault,),
                                    Text(item.bedroomsCount.toString(), style: Theme.of(context).textTheme.bodySmall!.copyWith()),
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
                                      "${item.city}, ${item.country}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 10),
                                    ),
                                  ],
                                ),
                                Text("${item.yearPrice} درهم / سنويا", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Theme.of(context).primaryColor),),



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
                            child: SvgPicture.asset("assets/images/heart2.svg",
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
        });
  }


}
