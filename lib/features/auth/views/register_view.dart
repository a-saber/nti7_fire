import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti7_fire/core/helper/my_navigator.dart';
import 'package:nti7_fire/features/home/views/home_view.dart';

import '../../../core/components/custom_btn.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/helper/show_snack_bar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomTextField(controller: email, hintText: 'Email'),
            SizedBox(height: 20),
            CustomTextField(controller: name, hintText: 'Name'),
            SizedBox(height: 20),
            CustomTextField(controller: phone, hintText: 'Phone'),
            SizedBox(height: 20),
            CustomTextField(controller: password, hintText: 'Password'),
            SizedBox(height: 30),

            if(isLoading)
              CircularProgressIndicator()
            else
              CustomBtn(text: 'Register', onTap: register),

          ],
        ),
      ),
    );
  }

  register() async{

    try {
      setState(() {
        isLoading = true;
      });

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      await FirebaseFirestore.instance.collection('users').doc(credential.user?.uid)
      .set({
        'name': name.text,
        'email': email.text,
        'phone': phone.text,
      });
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(context, text: 'Success\n${credential.user?.uid}', status: SnackBarStatus.success);
      goTo(context, page: HomeView(), state: MyNavigatorState.pushRemove);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = '${e.code} ${e.message}';
      if (e.code == 'weak-password') {
        errorMessage =  'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(context, text: errorMessage, status: SnackBarStatus.fail);

    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(context, text: 'Error', status: SnackBarStatus.fail);

    }

  }
}
