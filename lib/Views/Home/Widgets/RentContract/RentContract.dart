

import 'package:aqary/data/StateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Models/RealStateModel.dart';
import '../../../../ViewModel/UserViewModel.dart';
import '../../../../helper/Shimmer/ShimmerWidget.dart';
import '../../../../utill/dimensions.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import 'ContractDetails.dart';

class RentContract extends ConsumerStatefulWidget {
  const RentContract({super.key});

  @override
  ConsumerState<RentContract> createState() => _RentContractState();
}

class _RentContractState extends ConsumerState<RentContract> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(UserPropProvider.notifier).getUserProp(UserProp.available);


    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userProp = ref.watch(UserPropProvider);
    var realEstateIndex = ref.watch(contractEstateSelectionProvider);
    var userInfo = ref.watch(UserProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "إنشاء عقد إيجار",
        isCenter: true,
        isBackButtonExist: true,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: CustomButton(
              buttonText: "التالي",
              textColor: Colors.white,
              height: 50,
              borderRadius: 12,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ContractDetails(realStateModel: userProp.data![realEstateIndex],ownerName: userInfo.data!.name,ownerPhone: userInfo.data!.phone,)));
              }
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("اختر عقارا",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),),
                      Text(" لإنشاء عقد إيجار خاص به",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),),
                      SizedBox(height: Dimensions.paddingSizeLarge,),
                      userProp.handelState<List<RealStateModel>>(
                          onLoading: (state) => SizedBox(
                              height: MediaQuery.of(context).size.height*.6,
                              child: ShimmerList("Grid")),
                          onSuccess:(state)=> SizedBox(
                            height: MediaQuery.of(context).size.height*.75,
                            child: Expanded(
                              child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // number of items in each row
                                      mainAxisSpacing: 2.0, // spacing between rows
                                      crossAxisSpacing: 2.0, // spacing between columns
                                      mainAxisExtent: 250
                                  ),
                                  shrinkWrap: true,
                                  itemCount: userProp.data!.length,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context,index){
                                    var item = userProp.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Card(
                                              color: ref.watch(contractEstateSelectionProvider) == index ? Theme.of(context).primaryColor:Colors.white,
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      ref.read(contractEstateSelectionProvider.notifier).state = index;

                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        child: item.images.isEmpty?Container( height: 169,color: Colors.grey,)
                                                            :Image.network(
                                                          item.images.first.path,
                                                          height: 180,
                                                          width: 260,
                                                          fit: BoxFit.cover ,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(item.title,
                                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: ref.watch(contractEstateSelectionProvider) == index ? Colors.white : Colors.black)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 18,
                                            right: 18,
                                            child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Stack(
                                                children: [
                                                  Center(child: Container(width: 25,height:25,
                                                    decoration: BoxDecoration(color:ref.watch(contractEstateSelectionProvider) == index ? Theme.of(context).primaryColor: Colors.grey,borderRadius: BorderRadius.circular(50)),)),
                                                  Center(child: Text("✓",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),)),

                                                ],
                                              ),),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          onFailure: (state) =>Text("SHIT")
                      ),
                    ],
                  ),

                ])
        )
    );
  }

}
