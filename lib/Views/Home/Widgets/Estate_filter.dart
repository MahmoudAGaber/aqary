

import 'package:aqary/Models/CategoryModel.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ViewModel/CategoryViewModel.dart';
import '../../../utill/dimensions.dart';
import 'Estate_card.dart';

class EstateFilter extends ConsumerStatefulWidget {
  const EstateFilter({super.key});

  @override
  ConsumerState<EstateFilter> createState() => _EstateFilterState();
}

class _EstateFilterState extends ConsumerState<EstateFilter> {
  @override
  Widget build(BuildContext context) {
    var categories  = ref.watch(categoryProvider);

    return  categories.handelState<CategoryModel>(
      onLoading: (state) => Center(child: SizedBox(height:30,width:30,child: CircularProgressIndicator(color: Colors.grey,))),
        onSuccess: (state) => Column(
          children: [
            SizedBox(
              height: 42,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: ListView.builder(
                  itemCount: categories.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return filter(index,categories.data![index].title);
                  },
                ),
              ),
            ),
            SizedBox(height: Dimensions.paddingSizeDefault,),
            EstateCard(),
          ],
        ),
        onFailure: (state) => Center(child: Container(child: Text("shit")),)
    );
  }

  Widget filter(index,tag){
    return Consumer(
      builder: (context, ref, child){
        return InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Container(
                width: 107,
                height: 42,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color:Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(tag,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,)),
                )
            ),
          ),
        );
      },
    );
  }

  List<String> filterStrings = [
    "موصي به",
    "اعلي الاسعار",
    "افضل العروض",
  ];
}
