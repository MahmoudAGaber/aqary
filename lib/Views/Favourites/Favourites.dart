

import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/ViewModel/FavoritesViewModel.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../Models/CategoryModel.dart';
import '../../helper/ShimmerWidget.dart';
import '../../utill/dimensions.dart';
import '../Home/Widgets/Search/filterBS.dart';
import '../Home/Widgets/Search/searchItem.dart';
import '../base/custom_button.dart';
import '../base/custom_dialog.dart';
import '../base/custom_text_field.dart';
import 'Widgets/FavouriteItem.dart';

class Favourites extends ConsumerStatefulWidget {
  const Favourites({super.key});

  @override
  ConsumerState<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends ConsumerState<Favourites> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(favoritesProvider.notifier).getFavorites('desc', "favorite");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var favourites = ref.watch(favoritesProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: "المفضله",
        isBackButtonExist: false,
        leadingView: SizedBox(),
      ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault,),
              child: favourites.handelState<RealStateModel>(
                onLoading: (state) =>Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomTextField(
                    //         hintText: 'ابحث',
                    //         isIcon: true,
                    //         prefixIconUrl: CupertinoIcons.search,
                    //         isShowPrefixIcon: true,
                    //         inputAction: TextInputAction.search,
                    //         isSearch: true,
                    //         isShowBorder: true,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: Dimensions.paddingSizeLarge,
                    // ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "0 اعلانات ",
                              style:
                              Theme.of(context).textTheme.titleLarge,
                            ),
                            InkWell(
                                onTap: (){
                                  openDialog(
                                    FavFilteration(context),context, isDismissible: false,isDialog: true, willPop: true,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "الاحدث",
                                      style:
                                      Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ))
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),

                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height*.6,
                        child: ShimmerList("List")),
                  ],
                ),
                onSuccess: (state) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: 'ابحث',
                            isIcon: true,
                            prefixIconUrl: CupertinoIcons.search,
                            isShowPrefixIcon: true,
                            inputAction: TextInputAction.search,
                            isSearch: true,
                            isShowBorder: true,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${favourites.data!.length} اعلانات ",
                              style:
                              Theme.of(context).textTheme.titleLarge,
                            ),
                            InkWell(
                                onTap: (){
                                  openDialog(
                                    FavFilteration(context),context, isDismissible: false,isDialog: true, willPop: true,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "الاحدث",
                                      style:
                                      Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ))
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),

                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.7,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          FavouriteItem(properties: favourites.data,),
                        ],
                      ),
                    )

                  ],
                ),
                onFailure: (state) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 150),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 185,
                            width: 185,
                            child: Stack(
                              children: [
                                SvgPicture.asset("assets/images/Ellipse2.svg",colorFilter: ColorFilter.linearToSrgbGamma(),),
                                Center(child: SvgPicture.asset("assets/images/Ellipse2.svg",height: 156,width: 156,)),
                                Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(50)),)),
                                Center(child: Icon(Icons.add,color: Colors.white,size: 28,),),

                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "الصفحة المفضلة لديك فارغة",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 22),
                                overflow: TextOverflow.clip,
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeSmall,
                              ),
                              Text(
                                  "انقر فوق زر إضافة أعلاه لبدء الاستكشاف واختيار العقارات المفضلة لديك.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                    color: Colors.grey,
                                    overflow: TextOverflow.clip,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                  ),
        ));

  }

  Widget FavFilteration(context) {
    return SizedBox(
      height: 246,
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeDefault),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الترتيب حسب",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22)),
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close))
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeDefault,),
                Column(
                  children: List.generate(3, (index) => favIndex(index)),
                )


              ])
      ),
    );
  }

  Widget favIndex(index){
    return  Consumer(
      builder: (context, ref, child){
        var favoritesFilter = ref.watch(favoritesFilterProvider);
        return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              favFilterTxt[index],
              style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
            ),
            Checkbox(
              value: favoritesFilter.index ==  index,
              side: BorderSide(color: Colors.grey,width: 2),
              checkColor: Theme.of(context).colorScheme.surface,
              fillColor: MaterialStateProperty.resolveWith((states){
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context).primaryColor;
                }
                // inactive
                return Colors.white;
              }),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)
              ),
              activeColor: Colors.white,
              splashRadius: 30,
              onChanged: (bool? value) {
                ref.read(favoritesFilterProvider.notifier).state = FavoritesFilter.values[index];
                ref.read(favoritesProvider.notifier).getFavorites(favoritesFilter.name, favoritesFilter.name == "recently" ? "favorite": '');
                Navigator.pop(context);

              },
            ),
          ],
        );
      }
    );
  }

  List favFilterTxt = ['الأحدث','الأعلي سعرا','الأقل سعرا'];
}
