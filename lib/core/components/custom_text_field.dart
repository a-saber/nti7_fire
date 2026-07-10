import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hintText, this.prefixIcon, this.suffixIcon, this.validator, this.obscureText = false});
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 14.sp
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: Color(0xffCDCDCD),
              )
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color(0xff6E6A7C),
              fontSize: 14.sp,
              fontWeight: FontWeight.w200
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: Color(0xffCDCDCD),
              )
          )
      ),
    );
  }
}