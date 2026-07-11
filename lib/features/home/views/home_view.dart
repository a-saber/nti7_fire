import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti7_fire/core/helper/my_navigator.dart';
import 'package:nti7_fire/features/home/views/add_post_view.dart';

import '../../posts/presentation/views/my_posts_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
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
              return Text(userData['name']);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Upper Part
            Container(
              height: MediaQuery.of(context).size.height*0.2,
              color: Colors.blue,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(radius: 30.r, child: Icon(Icons.person)),
                  SizedBox(width: 15),
                  Text('User Name', style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
            
            SizedBox(height: 20,),
            ListTile(
              title: Text('My Posts'),
              subtitle: Text('show only my posts'),
              leading: Icon(Icons.task),
              onTap: ()=> goTo(context, page: MyPostsView()),
              trailing: Icon(Icons.arrow_forward),
            ),
            SizedBox(height: 20,),
            ListTile(
              title: Text('Profile'),
              subtitle: Text('can update profile'),
              leading: Icon(Icons.person),
              onTap: (){},
              trailing: Icon(Icons.arrow_forward),
            ),
            SizedBox(height: 20,),
            ListTile(
              title: Text('Settings'),
              subtitle: Text('can manage settings here'),
              leading: Icon(Icons.settings),
              onTap: (){},
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goTo(context, page: AddPostView()),
      ),
    );
  }
}
