import 'package:flutter/material.dart';

import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';

Future reportSuccessDialog(BuildContext context){

 return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(

            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(color: appColors.brandLite,borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: appColors.brandDark,
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  Text(
                    'Your report has been received. We will notify you soon.',
                    textAlign: TextAlign.center,
                    style: appFonts.f21w1000Black,
                  )
                ],
              ),
            ),
          ),
        );
      });
}