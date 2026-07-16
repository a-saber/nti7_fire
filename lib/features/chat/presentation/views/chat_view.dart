import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nti7_fire/core/components/custom_text_field.dart';
import 'package:nti7_fire/core/utils/app_colors.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key, required this.chatId,required this.userId, required this.userData});

  final String chatId;
  final String userId;
  final Map<String, dynamic> userData;
  final message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userData['name'] ?? '-')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('chat')
                  .doc(chatId).collection('messages').orderBy('created_at').snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData ){
                    var messagesData = snapshot.data?.docs??[];
                    return ListView.separated(
                      itemBuilder: (context, index) => MessageItemBuilder(data: messagesData[index].data()),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: messagesData.length,
                    );
                  }
                  return Text('Loading . . ');
                }
              ),
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: message,
              hintText: 'Enter your message here . . .',
              suffixIcon: IconButton(onPressed: sendMessage, icon: Icon(Icons.send)),
            ),
          ],
        ),
      ),
    );
  }
  sendMessage()async{
    try{
      await FirebaseFirestore.instance.collection('chat')
          .doc(chatId).collection('messages')
          .add({
        'message': message.text,
        'created_at': DateTime.now(),
        'sender_id': FirebaseAuth.instance.currentUser?.uid
      });
      message.clear();
    }
    catch(e){}
  }
}

class MessageItemBuilder extends StatelessWidget {
  const MessageItemBuilder({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    bool isFromMe = data['sender_id'] == FirebaseAuth.instance.currentUser?.uid;
    return Container(
      decoration: isFromMe?
      BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )
      ):
      BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data['message']??''),
          Text(((data['created_at']) as Timestamp).toDate().toString(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.black
          ),
          ),
        ],
      ),
    );
  }
}
