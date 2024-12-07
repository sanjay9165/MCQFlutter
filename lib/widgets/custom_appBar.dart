import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mcq/manager/font_manager.dart';


class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
     IconButton(
         onPressed: (){
           Get.back();
         },
         icon: const Icon(Icons.arrow_back_ios_new_rounded,)),
        const Spacer(flex: 4,),
        Text(title,style: appFonts.f20w600Black,),
        const Spacer(flex: 5,),
      ],
    );
  }
}
