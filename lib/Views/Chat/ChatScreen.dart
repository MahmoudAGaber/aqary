import 'dart:convert';

import 'package:aqary/Models/ChatModel.dart';
import 'package:aqary/Views/base/custom_imageView.dart';
import 'package:aqary/Views/base/custom_text_field.dart';
import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ViewModel/ChatViewModel.dart';
import '../../helper/Authentication.dart';
import '../../helper/date_converter.dart';
import '../../helper/file_picker.dart';

class ChatScreen extends ConsumerStatefulWidget {
  String chatRoomId;
  String? recipientId;
  String? recipientName;
  String? recipientPhone;
   ChatScreen({super.key,required this.chatRoomId,this.recipientId, this.recipientName,this.recipientPhone});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  TextEditingController textMessageEditingController = TextEditingController();
  FirebaseServices firebaseServices = FirebaseServices();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firebaseServices.markMessagesAsSeen(widget.chatRoomId, AuthService().auth.currentUser!.uid);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.pop(context);
                      },
                        child: Icon(Icons.arrow_back_ios)),
                    SizedBox(width: Dimensions.paddingSizeDefault,),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.all(Radius.circular(50)),
                    //   child: Image.asset(
                    //     "assets/images/profile.png",
                    //     width: 50,
                    //     height: 50,
                    //     fit: BoxFit.cover ,
                    //   ),
                    // ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.recipientName ?? widget.recipientPhone!, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "متصل الان",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 10),
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                // Container(
                //   height: 50,
                //   width: 50,
                //   decoration: BoxDecoration(
                //     color: Color(0xFFF5F4F7),
                //     borderRadius: BorderRadius.circular(50)
                //   ),
                //   child: Icon(Icons.call,size: 20,),
                // )
              ],
            ),
          ),
          SizedBox(height: Dimensions.paddingSizeDefault,),
          Expanded(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F4F7),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.69,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeExtraSmall),
                            child: StreamBuilder(
                              stream: FirebaseServices().fetchMessagesStream(widget.chatRoomId),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return SizedBox();
                                }
                                List<Message> messagess = snapshot.data!.docs.map((doc) {
                                  Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

                                  if (data != null) {
                                    return Message(
                                      message: data["message"],
                                      messageDate: data["messageDate"],
                                      messageId: data["messageId"],
                                      messageType: data["messageType"],
                                      seen: data["seen"],
                                      senderID: data["senderID"],
                                    );
                                  } else {
                                    return Message(); // Replace with your default Message constructor
                                  }
                                }).toList();

                                return ListView(
                                  reverse: true,
                                  children: [
                                    Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(messagess.length, (index) => messages(index,messagess),)),
                                    // SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Container(
                                    //       decoration: BoxDecoration(
                                    //           color: Theme.of(context).primaryColor,
                                    //           borderRadius: BorderRadius.circular(100)
                                    //       ),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    //         child: Text("December 12, 2022", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
                                    //       ),
                                    //
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                );
                              })
                            ),
                          ),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: textMessageEditingController,
                                    decoration: InputDecoration(
                                      hintText: "اكتب شيئا الان ..",
                                      prefixIcon: IconButton(onPressed: (){
                                        FilePickerHelper().pickFile(widget.chatRoomId,"Img",widget.recipientId!,
                                            widget.recipientName ??""
                                            , widget.recipientPhone!).then((value){
                                          FirebaseServices().sendMessage(
                                              widget.chatRoomId,
                                              value,
                                              "Img",
                                            widget.recipientId!,
                                            widget.recipientName ?? "",
                                              widget.recipientPhone!
                                          );
                                        });
                                      },
                                          icon: Icon(Icons.camera_alt_outlined,color: Colors.black54,)),
                                      hintStyle: TextStyle(height: 2),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: InkWell(
                                    onTap: (){
                                      FirebaseServices().sendMessage(
                                          widget.chatRoomId,
                                        textMessageEditingController.text,
                                        "Text",
                                          widget.recipientId!,
                                          widget.recipientName ?? "",
                                          widget.recipientPhone!
                                      );
                                      textMessageEditingController.clear();

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset("assets/images/send.svg",),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          )
        ]
      )
    );
  }

  Widget textMessage(bool currentUser, String message,String time){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: currentUser?Alignment.centerRight:Alignment.centerLeft,
        child: SizedBox(
          width: MediaQuery.of(context).size.width*.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: currentUser?Alignment.centerRight:Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: currentUser
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: currentUser
                                ?BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16),topLeft: Radius.circular(16))
                                :BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16),topRight: Radius.circular(16))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Text(message,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: currentUser?Colors.white:Colors.black),textAlign: currentUser ? TextAlign.start: TextAlign.end,),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: currentUser?MainAxisAlignment.start:MainAxisAlignment.end,
                      children: [
                       // SvgPicture.asset("assets/images/seen.svg"),
                        SizedBox(width: Dimensions.paddingSizeSmall,),
                        Text(
                          DateConverter.isoStringToLocalTimeWithAMPMOnly(time),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 10),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageMessage(bool currentUser, String imageUrl,String time){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment:  currentUser?Alignment.centerRight:Alignment.centerLeft,
        child: SizedBox(
          width: MediaQuery.of(context).size.width*.6,
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomChatImageView(imageUrl: imageUrl)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: imageUrl.isEmpty
                      ? (FilePickerHelper.localImgUrl != null
                      ? Image.memory(FilePickerHelper.localImgUrl!)
                      : Container(
                    color: Colors.grey, // Placeholder color
                    height: 180,
                    width: 250,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )) // Loading indicator or other placeholder
                      : Image.network(
                    imageUrl,
                    height: 180,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateConverter.isoStringToLocalTimeWithAMPMOnly(time),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 10),
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                   // SvgPicture.asset("assets/images/seen.svg")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget messages(index,List<Message> message){
      if(message[index].messageType == "Text"){
        return textMessage(message[index].senderID == FirebaseAuth.instance.currentUser!.uid, message[index].message!, message[index].messageDate!);
      }

      if(message[index].messageType == "Img"){
        return imageMessage(message[index].senderID == FirebaseAuth.instance.currentUser!.uid, message[index].message!, message[index].messageDate!);
      }

     return SizedBox();
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool isYesterday(DateTime date) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }

}
