

import 'package:flutter/material.dart';

import '../../../utill/dimensions.dart';
import 'AddEstate/AddEstate.dart';

class AddRealEstate extends StatelessWidget {
  const AddRealEstate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEstate()));
          },
          child: Text("إضافه الإعلان الخاص بك",style: Theme.of(context).textTheme.bodyLarge,),
          style: TextButton.styleFrom(
            fixedSize: Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: Theme.of(context).primaryColor,
                width: 3
              ),
            ),
          ),
        ),
      ),
    );
  }
}
