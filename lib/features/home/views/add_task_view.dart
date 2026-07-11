import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti7_fire/core/components/custom_btn.dart';
import 'package:nti7_fire/core/components/custom_text_field.dart';
import 'package:nti7_fire/core/helper/show_snack_bar.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var title = TextEditingController();
  var desc = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomTextField(controller: title, hintText: 'Title'),
            SizedBox(height: 20),
            CustomTextField(controller: desc, hintText: 'Desc'),
            SizedBox(height: 30),

            if(isLoading)
              CircularProgressIndicator()
            else
            CustomBtn(text: 'Add Task', onTap: addTask),
          ],
        ),
      ),
    );
  }

  addTask() async{
    try {
      setState(() {
        isLoading = true;
      });
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('tasks')
          .add({
        'title': title.text,
        'desc': desc.text
      });
      // print(result);
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(context, text: 'Success', status: SnackBarStatus.success);
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(context, text: 'Error', status: SnackBarStatus.fail);

    }
  }
}
