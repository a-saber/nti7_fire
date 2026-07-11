import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nti7_fire/core/helper/my_navigator.dart';
import 'package:nti7_fire/features/home/views/add_task_view.dart';

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

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Text('${data['name']} ${data['phone']}');
            }

            return Text("loading");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            goTo(context, page: AddTaskView());
          }),
      // body: FutureBuilder(
      //     future: future, builder: builder),
    );
  }
}
