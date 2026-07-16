import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti7_fire/core/components/custom_btn.dart';
import 'package:nti7_fire/core/helper/my_navigator.dart';

import '../../../chat/presentation/views/chat_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userData, required this.userId});

  final String userId;
  final Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  radius: 60.r,
                ),
                SizedBox(height: 20,),
                Text(userData['name'], style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 20,),

                Text(userData['phone'], style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 20,),

                Text(userData['email'], style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 30,),

                if(userId != FirebaseAuth.instance.currentUser?.uid)
                CustomBtn(text: 'Chat With', onTap: ()async{
    try{
      // check if chat exist for these two users
      String chatId;

      var result = await FirebaseFirestore.instance.collection('chat').where(
        'users',isEqualTo: [
        FirebaseAuth.instance.currentUser?.uid??'',
        userId
      ]..sort()
      ).get();
      if(result.docs.isEmpty){
        var newChat = await FirebaseFirestore.instance.collection('chat')
            .add({
          'users': [
            FirebaseAuth.instance.currentUser?.uid,
            userId
          ]..sort()
        });
        chatId = newChat.id;
      }
      else{
        chatId = result.docs.first.id;
      }

      goTo(context, page: ChatView(
        chatId: chatId,
        userId: userId,
        userData: userData,
      ));
    }
    catch(e){
      print('error ${e.toString()}');
    }


                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
