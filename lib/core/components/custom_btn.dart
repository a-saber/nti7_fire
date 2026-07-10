import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.text, required this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff149954),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 0,
              color: Color(0xff149954),
            ),
          ],
        ),
        padding: REdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 19.sp,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
