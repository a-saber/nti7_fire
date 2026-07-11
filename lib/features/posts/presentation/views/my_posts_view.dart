import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/post_item_builder.dart';

class MyPostsView extends StatelessWidget {
  const MyPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts')
              .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          // .orderBy(field)
              .get(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Text('error');
            }
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          var posts = snapshot.data?.docs;
          return ListView.separated(
            padding: REdgeInsets.all(20),
            itemBuilder: (context, index) => PostItemBuilder(
              data: posts?[index].data() ??{},
            ),
            separatorBuilder:  (context, index) =>SizedBox(height: 20,),
            itemCount: posts?.length??0,
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
