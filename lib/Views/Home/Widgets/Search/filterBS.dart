
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FilterSearch {
  RangeValues _currentRangeValues = const RangeValues(100000, 200000);
  void filterSearch(BuildContext context) {
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
                                  Text('  1500 درهم _ 80000 درهم',
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black45),),
                                  RangeSlider(
                                    values: _currentRangeValues,
                                    max: 300000,
                                    divisions: 5,
                                    activeColor: Theme.of(context).primaryColor,
                                    inactiveColor: Colors.grey,
                                    overlayColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                                    labels: RangeLabels(
                                      _currentRangeValues.start.round().toString(),
                                      _currentRangeValues.end.round().toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      _currentRangeValues = values;
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
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Theme.of(context).primaryColor,
                                                child: Icon(Icons.add,color: Colors.white,),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                                child: Text('2',
                                                  style: Theme.of(context).textTheme.bodyLarge,),
                                              ),
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.grey,
                                                child: Container(
                                                    width: 14,
                                                    height: 2,
                                                    color: Colors.white,
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
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Theme.of(context).primaryColor,
                                                child: Icon(Icons.add,color: Colors.white,),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                                child: Text('1',
                                                  style: Theme.of(context).textTheme.bodyLarge,),
                                              ),
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.grey,
                                                child: Container(
                                                  width: 14,
                                                  height: 2,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
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
                                            onPressed: (){},
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
                                        SizedBox(width: Dimensions.paddingSizeLarge,),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: (){},
                                            child: Text("إعادة تعيين",
                                              style:  Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).primaryColor),
                                            ),
                                            style: TextButton.styleFrom(
                                              fixedSize: Size.fromHeight(52),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Theme.of(context).primaryColor
                                                ),
                                              ),
                                            ),),
                                        ),
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
        return InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
                width: 75,
                height: 42,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color:Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Text(filterStrings[index],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,)),
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
        return InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
                width: 78,
                height: 38,
                decoration: BoxDecoration(
                    color: index == 0 ?Theme.of(context).primaryColor: null,
                    border: Border.all(
                      color: index == 0 ?Theme.of(context).primaryColor: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Text(filterArrangeStrings[index],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: index  == 0 ?Colors.white: Colors.black,)),
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