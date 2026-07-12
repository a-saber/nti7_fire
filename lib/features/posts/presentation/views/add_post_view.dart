import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti7_fire/core/components/custom_btn.dart';
import 'package:nti7_fire/core/components/custom_text_field.dart';
import 'package:nti7_fire/core/helper/show_snack_bar.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  var title = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomTextField(controller: title, hintText: 'Title'),
            SizedBox(height: 30),

            if(isLoading)
              CircularProgressIndicator()
            else
            CustomBtn(text: 'Submit', onTap: newPost),
          ],
        ),
      ),
    );
  }

  newPost() async{
    try{
      setState(() {
        isLoading = true;
      });

      await FirebaseFirestore.instance
      .collection('posts').add({
        'title': title.text,
        'user_id': FirebaseAuth.instance.currentUser?.uid,
        'created_at': DateTime.now()
      });
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(context, text: 'Post published', status: SnackBarStatus.success);
    }
        catch(e){
          showCustomSnackBar(context, text: 'Post Failed', status: SnackBarStatus.fail);
          setState(() {
            isLoading = false;
          });
        }
  }
}
