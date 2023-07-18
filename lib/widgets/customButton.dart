import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/const/AppColors.dart';

Widget customButton (String buttonText,onPressed, colorvalue,Colors){
  return SizedBox(
    width: 3.sw,
    height: 40.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Colors,
            fontSize: 18.sp),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(colorvalue),
       // foregroundColor: Color(textcolorvalue),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)

        ),
        elevation: 1,
      ),
    ),
  );
}