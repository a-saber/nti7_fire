import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti7_fire/core/helper/my_navigator.dart';
import 'package:nti7_fire/features/auth/views/register_view.dart';

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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomTextField(controller: email, hintText: 'Email'),
            SizedBox(height: 20),
            CustomTextField(controller: password, hintText: 'Password'),
            SizedBox(height: 30),

            if(isLoading)
              CircularProgressIndicator()
            else
              CustomBtn(text: 'Login', onTap: login),

            TextButton(onPressed: (){
              goTo(context, page: RegisterView());
            }, child: Text('Already have an account? Register Now', textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }

  login()async{}
}
