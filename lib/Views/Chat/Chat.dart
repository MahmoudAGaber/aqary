

import 'package:aqary/Models/ChatModel.dart';
import 'package:aqary/Views/Chat/ChatScreen.dart';
import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:aqary/helper/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../ViewModel/ChatViewModel.dart';
import '../../helper/date_converter.dart';
import '../../utill/dimensions.dart';
import '../base/custom_app_bar.dart';
import '../base/custom_text_field.dart';

class Chat extends ConsumerStatefulWidget {
  const Chat({super.key});

  @override
  ConsumerState<Chat> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {

  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var searchUsers = ref.watch(searchUserProvider);
    bool isSearchTap = false;
    print(searchUsers);
    return Scaffold(
        appBar: CustomAppBar(
          title: "الرسائل",
          isBackButtonExist: false,
          leadingView: SizedBox(),
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
                    controller: searchEditingController,
                    hintText: 'ابحث',
                    isIcon: true,
                    prefixIconUrl: CupertinoIcons.search,
                    isShowPrefixIcon: true,
                    isShowSuffixIcon:  ref.watch(isSearchTapProvider),
                    inputAction: TextInputAction.search,
                    isSearch: true,
                    isShowBorder: true,
                    suffixIconUrl: Icons.close,
                    onSuffixTap: (){
                      ref.read(isSearchTapProvider.notifier).state = false;
                      ref.read(searchUserProvider.notifier).state = [];
                      searchEditingController.clear();

                    },
                    onChanged: (value){

                      ref.read(searchUserProvider.notifier).filterUsers(value);
                    },
                    onTap: (){
                      ref.read(isSearchTapProvider.notifier).state = true;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  searchUsers == [] || searchUsers.isEmpty || searchUsers == null
                      ? FutureBuilder(
                        future: FirebaseServices().getUserChatsStream(),
                      builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Row(
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
                                            Center(child: Icon(Icons.messenger_outline,color: Colors.white,size: 28,),),

                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "لا يوجد لديك اي محادثة",
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
                                              "انقر ابحث وقم بالمحادثة الآن.",
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
                            );
                          } else {
                            final chatDocs = snapshot.data!;
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: chatDocs.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var item = chatDocs[index].docs.first;
                                  return Dismissible(
                                    key: Key("Uniqe"),
                                    direction: DismissDirection.startToEnd,
                                    background: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                      ),
                                      child: Align(alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Icon(CupertinoIcons.delete, color: Colors.white,
                                              size: 26,),
                                          )),
                                    ),
                                    child: SizedBox(
                                      height: 100,
                                      child: Card(
                                        child: InkWell(
                                          onTap: () async {
                                            String chatRoomId = await FirebaseServices().createChatRoom(AuthService().auth.currentUser!.uid, item.get('senderID'), Message().toJson());
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => ChatScreen(chatRoomId: chatRoomId,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50)),
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("ds", style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontWeight: FontWeight.w600)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: Text(item.get('messageType') == "Img"
                                                ? "Img"
                                            :item.get('message'),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(fontSize: 10),
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    DateConverter.isoStringToLocalTimeWithAMPMOnly(item.get('messageDate')),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                        color: Colors.grey, fontSize: 11)
                                ),
                                Container(
                                  height: 18, width: 18,
                                  decoration: BoxDecoration(
                                      color: Theme
                                          .of(context)
                                          .primaryColor
                                          .withOpacity(.7),
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Center(
                                    child: Text(
                                        '1',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color: Colors.white, fontSize: 12)
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
            });
                          }
                        })
                      :ListView.builder(
                   shrinkWrap: true,
                   itemCount: searchUsers.length,
                     physics: NeverScrollableScrollPhysics(),
                     itemBuilder:(context, index){
                     var item = searchUsers[index].get;
                     print("OLll${item('userId')}");
                   return SizedBox(
                     child: Card(
                       child: InkWell(
                         onTap: ()async{
                           String chatRoomId = await FirebaseServices().createChatRoom(AuthService().auth.currentUser!.uid, item('userId'), Message().toJson());

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
                                 child: Text(item('userName') == 'userName'
                                     ? item('mobileNumber')
                                     : item('userName'),
                                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600)),
                               ),

                             ],
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
