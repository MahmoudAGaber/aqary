

import 'package:aqary/Models/ChatModel.dart';
import 'package:aqary/Views/Chat/ChatScreen.dart';
import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../ViewModel/ChatViewModel.dart';
import '../../utill/dimensions.dart';
import '../base/custom_app_bar.dart';
import '../base/custom_text_field.dart';

class Chat extends ConsumerStatefulWidget {
  const Chat({super.key});

  @override
  ConsumerState<Chat> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "الرسائل",
          isBackButtonExist: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "جميع الرسائل",
                        style:
                        Theme.of(context).textTheme.titleLarge!.copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge,),
                  CustomTextField(
                    hintText: 'ابحث',
                    isIcon: true,
                    prefixIconUrl: CupertinoIcons.search,
                    isShowPrefixIcon: true,
                    inputAction: TextInputAction.search,
                    isSearch: true,
                    isShowBorder: true,
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  ListView.builder(
                   shrinkWrap: true,
                   itemCount: 10,
                     physics: NeverScrollableScrollPhysics(),
                     itemBuilder:(context, index){
                   return Dismissible(
                     key: Key("Uniqe"),
                     direction: DismissDirection.startToEnd,
                     background: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Theme.of(context).primaryColor,

                       ),
                       child: Align(
                           alignment: Alignment.centerRight,
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 20),
                             child: Icon(CupertinoIcons.delete,color: Colors.white,size: 26,),
                           )),
                     ),
                     child: SizedBox(
                       height: 100,
                       child: Card(
                         child: InkWell(
                           onTap: ()async{
                             String chatRoomId = await FirebaseServices().createChatRoom("1", "3", Message().toJson());

                             Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(chatRoomId: chatRoomId,)));

                           },
                           child: Padding(
                             padding: const EdgeInsets.all(12),
                             child: Row(
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.all(Radius.circular(50)),
                                   child: Image.asset(
                                     "assets/images/profile.png",
                                     width: 50,
                                     height: 50,
                                     fit: BoxFit.cover ,
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text("احمد مصطفي", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600)),
                                       Flexible(
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             SizedBox(
                                               width: MediaQuery.of(context).size.width*.595,
                                               child: Text(
                                                 "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص",
                                                 style: Theme.of(context)
                                                     .textTheme
                                                     .bodySmall!
                                                     .copyWith(fontSize: 10),
                                                 overflow: TextOverflow.clip,
                                                 softWrap: true,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),



                                     ],
                                   ),
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                      Text(
                                         '10.45',
                                         style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey,fontSize: 11)
                                       ),
                                     Container(
                                       height: 18,width: 18,
                                       decoration: BoxDecoration(
                                           color: Theme.of(context).primaryColor.withOpacity(.7),
                                           borderRadius: BorderRadius.circular(50)
                                       ),
                                       child: Center(
                                         child: Text(
                                             '1',
                                             style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white,fontSize: 12)
                                         ),
                                       ),
                                     )
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                   );
                 })

                ],
              )),
        ));
  }
}
