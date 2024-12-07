import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../manager/color_manager.dart';
import '../manager/font_manager.dart';





customSnackBar({required String title,
  required String message,int? duration,
    bool? isError}){
  AppColors appColors =  AppColors();
  AppFonts appFont = AppFonts();
  return Get.snackbar(
    title, message,
    borderRadius: 20,
    borderWidth: 3,
    backgroundColor: Colors.white.withOpacity(0.7),
    borderColor:isError ?? false ? Colors.red : appColors.brandDark,
    duration:  Duration(seconds: duration ?? 2),
    titleText: Center(child: Text(title,style:appFont.f14w400Grey,)),
    messageText:  Center(child: Text(message,
        style: isError ?? false ?
    appFont.f16w600Black.copyWith(
      color: Colors.red
    ):
    appFont.f16w600Black)),
    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
    colorText: Colors.white,
  );
}