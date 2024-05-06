
import 'package:aqary/ViewModel/RealStateViewModel.dart';
import 'package:aqary/ViewModel/UserViewModel.dart';
import 'package:aqary/helper/date_converter.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ViewModel/SearchViewModel.dart';


class MoreEstateFilter {
  void estatesFilter(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height*.889;
    TextEditingController searchController = TextEditingController();
    showModalBottomSheet<void>(
      isScrollControlled:true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      context: context,
      builder: (BuildContext context) {
        return Consumer(
            builder: (context, ref, child) {
              var type = ref.watch(filterProvider);
              var sortBy = ref.watch(SortByProvider);
              var bedroomNumbers = ref.watch(bedRoomSeProvider);
              var bathroomNumbers = ref.watch(bathroomSeProvider);
              var rangSlider = ref.watch(rangeValuesProvider);
              return  WillPopScope(
                onWillPop: ()async{

                  return true;
                },
                child: Container(
                    height: screenHeight,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeDefault),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Center(
                                  child: Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        width: 3,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('تصفيه',
                                      style: Theme.of(context).textTheme.titleLarge,),
                                    InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.close))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('الفئه',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),),
                                ],
                              ),
                              SizedBox(height: Dimensions.paddingSizeDefault,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(filterStrings.length, (index) => filter(index))
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                child: Divider(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('السعر',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),),
                                  Text(' ${DateConverter.numberFormat(rangSlider.start.round()).toString()} درهم  -  ${DateConverter.numberFormat(rangSlider.end.round()).toString()} درهم',
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black45),),
                                  RangeSlider(
                                    values: rangSlider,
                                    max: rangSlider.end+300000,
                                    divisions: 50,
                                    activeColor: Theme.of(context).primaryColor,
                                    inactiveColor: Colors.grey,
                                    overlayColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),

                                    onChanged: (RangeValues values) {
                                      ref.read(rangeValuesProvider.notifier).updateRangeValues(values);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                    child: Divider(),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('غرفه نوم',
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16,color:  Color(0xff677294)),),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  ref.read(bedRoomSeProvider.notifier).state ++;
                                                },
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:Theme.of(context).primaryColor,
                                                  child: Icon(Icons.add,color: Colors.white,),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                child: Text(bedroomNumbers.toString(),
                                                  style: Theme.of(context).textTheme.bodyLarge,),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  if(bedroomNumbers > 1){
                                                    ref.read(bedRoomSeProvider.notifier).state --;

                                                  }
                                                },
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.grey,
                                                  child: Container(
                                                    width: 14,
                                                    height: 2,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.paddingSizeDefault,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('حمام',
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16,color:  Color(0xff677294)),),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  ref.read(bathroomSeProvider.notifier).state ++;
                                                },
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:Theme.of(context).primaryColor,
                                                  child: Icon(Icons.add,color: Colors.white,),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                child: Text(bathroomNumbers.toString(),
                                                  style: Theme.of(context).textTheme.bodyLarge,),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  if(bathroomNumbers > 1){
                                                    ref.read(bathroomSeProvider.notifier).state --;

                                                  }
                                                },
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.grey,
                                                  child: Container(
                                                    width: 14,
                                                    height: 2,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                    child: Divider(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('رتب حسب',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.paddingSizeDefault,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: List.generate(filterStrings.length, (index) => filterArrange(index))
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                    child: Divider(),
                                  ),
                                  Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: (){
                                              ref.read(RealStateProvider.notifier).getRealStates(
                                                 type:  type.index == 0 ? "": type.name,
                                                  fromPrice: rangSlider.start,
                                                  toPrice: rangSlider.end,
                                                  bedrooms: bedroomNumbers,
                                                  bathroom: bathroomNumbers,
                                                  sort_type :sortBy.index == 0 ? "": sortBy.name,
                                                  page: 1,
                                                  limit: 20
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text("تطبيق",
                                              style:  Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Theme.of(context).primaryColor,
                                              fixedSize: Size.fromHeight(52),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Theme.of(context).primaryColor
                                                ),
                                              ),
                                            ),),
                                        ),
                                        // SizedBox(width: Dimensions.paddingSizeLarge,),
                                        // Expanded(
                                        //   child: TextButton(
                                        //     onPressed: (){},
                                        //     child: Text("إعادة تعيين",
                                        //       style:  Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).primaryColor),
                                        //     ),
                                        //     style: TextButton.styleFrom(
                                        //       fixedSize: Size.fromHeight(52),
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius: BorderRadius.circular(10),
                                        //         side: BorderSide(
                                        //             color: Theme.of(context).primaryColor
                                        //         ),
                                        //       ),
                                        //     ),),
                                        // ),
                                      ]
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                    )
                ),
              );
            }
        );
      },
    );
  }

  Widget filter(index){
    return Consumer(
      builder: (context, ref, child){
        var type = ref.watch(filterProvider);
        return InkWell(
          onTap: (){
            ref.read(filterProvider.notifier).state = FilterType.values[index];
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
                width: 75,
                height: 42,
                decoration: BoxDecoration(
                    color: type.index == index ? Theme.of(context).primaryColor : Colors.white,
                    border: Border.all(
                      color:Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Text(filterStrings[index],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: type.index == index? Colors.white: Colors.black,)),
                )
            ),
          ),
        );
      },
    );
  }

  Widget filterArrange(index){
    return Consumer(
      builder: (context, ref, child){
        var sort = ref.watch(SortByProvider);
        return InkWell(
          onTap: (){
            ref.read(SortByProvider.notifier).state = SortBy.values[index];
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
                width: 78,
                height: 38,
                decoration: BoxDecoration(
                    color: sort.index == index ?Theme.of(context).primaryColor: Colors.white,
                    border: Border.all(
                      color:Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Text(filterArrangeStrings[index],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: sort.index == index ?Colors.white: Colors.black,)),
                )
            ),
          ),
        );
      },
    );
  }
  List<String> filterStrings = [
    "الكل",
    "شقة",
    "فيلا",
  ];

  List<String> filterArrangeStrings = [
    "الاحدث",
    "أعلي سعر",
    "أقل سعر",
  ];
}