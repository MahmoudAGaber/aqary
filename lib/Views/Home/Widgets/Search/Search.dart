import 'package:aqary/Models/CategoryModel.dart';
import 'package:aqary/Models/UserModel.dart';
import 'package:aqary/ViewModel/SearchViewModel.dart';
import 'package:aqary/ViewModel/UserViewModel.dart';
import 'package:aqary/Views/Home/Widgets/Estate_card.dart';
import 'package:aqary/Views/Home/Widgets/Search/searchItem.dart';
import 'package:aqary/Views/Home/Widgets/Search/searchRecentItem.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utill/dimensions.dart';
import '../../../base/custom_text_field.dart';
import 'filterBS.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  FocusNode textFocusNode = FocusNode();
  TextEditingController searchEditController = TextEditingController();
  bool notFound = true;
  bool searchResult = true;

  @override
  Widget build(BuildContext context) {
    var searchResults = ref.watch(SearchProvider);
    var user = ref.watch(UserProvider);
    print("USerOK${user}");
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(textFocusNode);
        ref.read(SearchProvider.notifier).clearSearch();
        searchEditController.clear();
        return true;
      },
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeDefault,
                  bottom: Dimensions.paddingSizeDefault,
                  right: Dimensions.paddingSizeDefault,
                  top: 60),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            FocusScope.of(context).requestFocus(textFocusNode);
                            ref.read(SearchProvider.notifier).clearSearch();
                            searchEditController.clear();
                          },
                          child: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: Dimensions.paddingSizeSmall,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: searchEditController,
                          hintText: 'ابحث',
                          isIcon: true,
                          prefixIconUrl: CupertinoIcons.search,
                          isShowSuffixIcon: true,
                          isShowPrefixIcon: true,
                          inputAction: TextInputAction.search,
                          isSearch: true,
                          isShowBorder: true,
                          onChanged: (value){
                            ref.read(SearchProvider.notifier).getSearch(value);
                          },
                          onSubmit:(value){
                           // ref.read(SearchProvider.notifier).getSearch(value);
                          } ,
                          suffixIconUrl: CupertinoIcons.clear,
                          onSuffixTap: (){
                            ref.read(SearchProvider.notifier).clearSearch();
                            searchEditController.clear();
                          },

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
                        searchResults.handelState(
                          onLoading: (state) => user.handelState<UserModel>(
                              onLoading: (state) => Center(
                                  child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ))),
                              onSuccess: (state) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            user.data!.searchHistory.isNotEmpty
                                                ? "عمليات البحث الأخيرة"
                                                : "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          // Text("امسح الكل",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.paddingSizeLarge,
                                      ),
                                      Wrap(
                                          children: List.generate(
                                        user.data!.searchHistory.length,
                                        (index) => lastSearchs(user.data!, index),
                                      )),
                                      SizedBox(
                                        height: Dimensions.paddingSizeLarge,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.data!.recentlySeen.isNotEmpty
                                                ? "ما شاهدته مؤخرا"
                                                : "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.paddingSizeDefault,
                                      ),
                                      SearcgRecentItem()
                                    ],
                                  ),
                              onFailure: (state) => Center(
                                    child: Container(child: Text("shit")),
                                  )),
                          onSuccess: (state) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "تم العثور على ${searchResults.data!.length} إعلان",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        FilterSearch().filterSearch(context);
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/filter.svg'))
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeDefault,
                              ),
                              SearchItem()
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
                                          SvgPicture.asset(
                                            "assets/images/Ellipse2.svg",
                                            colorFilter:
                                                ColorFilter.linearToSrgbGamma(),
                                          ),
                                          Center(
                                              child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          )),
                                          Center(
                                              child: SvgPicture.asset(
                                            "assets/images/sad.svg",
                                            color: Theme.of(context).primaryColor,
                                            height: 36,
                                          )),
                                          Positioned(
                                            top: 55,
                                            right: 60,
                                            child: Text(
                                              '?',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: Dimensions
                                                      .fontSizeExtraLarge,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 80,
                                            left: 58,
                                            child: Text(
                                              '?',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "لم يتم العثور عليه",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 22),
                                          overflow: TextOverflow.clip,
                                        ),
                                        SizedBox(
                                          height: Dimensions.paddingSizeSmall,
                                        ),
                                        Text(
                                            "لا يوجد نتيجه من شقه, حاول بكلمه بحث اخري",
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
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  Widget lastSearchs(UserModel user, index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: (){
          ref.read(SearchProvider.notifier).getSearch(user.searchHistory[index]);
          searchEditController.text = user.searchHistory[index];
        },
        child: Container(
          width: 63,
          height: 30,
          decoration: BoxDecoration(
              color: Color(0x38C8E5A4), borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Center(
              child: (
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      user.searchHistory[index],
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Theme.of(context).primaryColor,overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  // Icon(
                  //   Icons.close,
                  //   color: Theme.of(context).primaryColor,
                  //   size: 12,
                  // )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
