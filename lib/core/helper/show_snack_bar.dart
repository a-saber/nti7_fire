
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

enum SnackBarStatus {success, fail, warning, info}


showCustomSnackBar(context, {required String text, required SnackBarStatus status}){
  Color background;
  IconData icon;
  switch(status){
    case SnackBarStatus.success:
      background = AppColors.primary;
      icon = Icons.check_circle;
    case SnackBarStatus.fail:
      background = AppColors.error;
      icon = Icons.error;
    case SnackBarStatus.warning:
      background = AppColors.warning;
      icon = Icons.warning;
    case SnackBarStatus.info:
      background = AppColors.info;
      icon = Icons.info;
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: background,
      content: Row(
        children: [
          Icon(icon, color: Colors.white,),
          SizedBox(width: 10,),
          Expanded(
            child: Text(text,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white
              ),),
          ),
        ],
      )));
}