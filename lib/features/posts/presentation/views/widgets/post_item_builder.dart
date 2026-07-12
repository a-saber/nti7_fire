import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/my_navigator.dart';
import '../../../../profile/presentation/views/profile_view.dart';

class PostItemBuilder extends StatelessWidget {
  const PostItemBuilder({super.key, required this.data, required this.postId});
  final String postId;
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // post header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(data['user_id'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }

                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          var userData = snapshot.data?.data() as Map<String, dynamic>;
                          return InkWell(
                              onTap: ()=> goTo(context, page: ProfileView(userData: userData,
                              userId:  snapshot.data!.id,)),
                              child: Text(userData['name']));
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    Text((data['created_at'] as Timestamp?)?.toDate().toString()??'-', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey
                    ),),
                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
            ],
          ),
          Divider(),

          // Body
          Text(data['title']??'-'),
          SizedBox(height: 10,),
          Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqf-LX3h-6FiPw4BtjuprZx3I-aYxTUQPdwE7zDL1fK6hSwyYwpaabPw89&s=10'),

          // Actions Row
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
            IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
            IconButton(onPressed: (){}, icon: Icon(Icons.share)),
          ],)
        ],
      ),
    );
  }
}
