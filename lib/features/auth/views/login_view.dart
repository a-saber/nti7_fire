import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti7_fire/core/helper/my_navigator.dart';
import 'package:nti7_fire/core/helper/show_snack_bar.dart';
import 'package:nti7_fire/features/auth/views/register_view.dart';
import 'package:nti7_fire/features/home/views/home_view.dart';

import '../../../core/components/custom_btn.dart';
import '../../../core/components/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var email = TextEditingController();
  var password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomTextField(controller: email, hintText: 'Email'),
            SizedBox(height: 20),
            CustomTextField(controller: password, hintText: 'Password'),
            SizedBox(height: 30),

            if (isLoading)
              CircularProgressIndicator()
            else
              CustomBtn(text: 'Login', onTap: login),

            TextButton(
              onPressed: () {
                goTo(context, page: RegisterView());
              },
              child: Text(
                'Already have an account? Register Now',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    try {
      setState(() {
        isLoading = true;
      });
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      setState(() {
        isLoading = false;
      });
      goTo(context, page: HomeView(), state: MyNavigatorState.pushRemove);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(
        context,
        text: '${e.code} ${e.message}',
        status: SnackBarStatus.fail,
      );
    } catch (e) {
      String errorMsg = 'Error';
      if(e is FirebaseAuthException){
        errorMsg = '${e.code} ${e.message}';
      }
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar(context, text: errorMsg, status: SnackBarStatus.fail);
    }
  }
}
