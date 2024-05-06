

import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/ViewModel/CategoryViewModel.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helper/ShimmerWidget.dart';
import '../../../utill/dimensions.dart';
import 'EstateDetails.dart';
import 'MoreEstates.dart';

class EstateNearYou extends ConsumerStatefulWidget {
  const EstateNearYou({super.key});

  @override
  ConsumerState<EstateNearYou> createState() => _EstateNearYouState();
}

class _EstateNearYouState extends ConsumerState<EstateNearYou> {
  @override
  Widget build(BuildContext context) {
    var nearBy = ref.watch(nearByProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("بالقرب منك", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18)),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreEstates()));
                  },
                    child: Text("المزيد",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor))),
              ],
            ),
          ),
         SizedBox(height: Dimensions.paddingSizeSmall,),
          nearBy.handelState<RealStateModel>(
              onLoading: (state) => SizedBox(
                height: 400,
                  child: ShimmerList("List")),
            onSuccess: (state)=> ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: nearBy.data!.length > 30 ? 30 : nearBy.data!.length,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemBuilder: (context,index){
                  var item = nearBy.data![index];
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                                    child: InkWell(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails()));

                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: item.images.isEmpty
                                            ? SizedBox()
                                            :Image.network(
                                          item.images.first.path,
                                          width: 132,
                                          height: 88,
                                          fit: BoxFit.cover ,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.title, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                                        SizedBox(height: 3,),
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
                                        SizedBox(height: 3,),

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
                                        SizedBox(height: 3,),
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
                }),
            onFailure: (state)=> Text("SHIT")
          )
        ],
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

  ];
}
