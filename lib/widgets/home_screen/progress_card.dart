import 'package:flutter/material.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';


class ProgressCard extends StatelessWidget {
  final bool isProgress;
  const ProgressCard({super.key, required this.isProgress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      isProgress ?
                      "Great Progress 🔥" :
                      "Rise Strong 🔥",
                    style: appFonts.f14w600Black,),
                    Text(
                      isProgress ?
                      "You are completely on track, keep it up!" :
                      "Every setback is a setup for a comeback;\n keep pushing forward.",
                      style: appFonts.f12w600Grey,),
                  ],
                ),
                Image.asset(isProgress ?
                appImages.progress :
                appImages.decrease,
                  width: 90,
                  height: 70,
                )

              ],
            ),
          )
        ),
      ),
    );
  }
}
