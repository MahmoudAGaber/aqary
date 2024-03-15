

import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utill/dimensions.dart';
import '../Home/Widgets/Search/filterBS.dart';
import '../Home/Widgets/Search/searchItem.dart';
import '../base/custom_button.dart';
import '../base/custom_dialog.dart';
import '../base/custom_text_field.dart';
import 'Widgets/FavouriteItem.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool notFound = true;
  bool favouriteResult = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "المفضله",
        isBackButtonExist: false,
      ),
        body: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault,),
            child: !notFound
                ? Row(
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
            )
                :Column(
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
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "4 اعلانات",
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
                          FavouriteItem()
                        ],
                      ),

                    ],
                  ),
                )

              ],
            )));
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
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          favFilterTxt[index],
          style:
          Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
        ),
        Checkbox(
          value: index == 0?true:false,
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
          onChanged: (bool? value) {},
        ),
      ],
    );
  }

  List favFilterTxt = ['الأحدث','الأعلي سعرا','الأقل سعرا'];
}
