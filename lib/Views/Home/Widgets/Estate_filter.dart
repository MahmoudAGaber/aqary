

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EstateFilter extends StatefulWidget {
  const EstateFilter({super.key});

  @override
  State<EstateFilter> createState() => _EstateFilterState();
}

class _EstateFilterState extends State<EstateFilter> {
  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(filterStrings.length, (index) => filter(index))
    );
  }

  Widget filter(index){
    return Consumer(
      builder: (context, ref, child){
        return InkWell(
          onTap: (){},
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
                child: Text(filterStrings[index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,)),
              )
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
