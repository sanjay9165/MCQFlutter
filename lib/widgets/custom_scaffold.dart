
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/space_manager.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key, required this.content,this.headerImage, required this.headerTitle, required this.headerIconBg, this.bottomSheet, this.headerIcon,
  });
  final Widget content;
  final Color headerIconBg;
  final String? headerImage;
  final Icon? headerIcon;

  final String headerTitle;
  final Widget? bottomSheet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.brandDark,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                Text(
                  headerTitle,
                  style: appFonts.f20w700White,
                ),
                appSpaces.spaceForWidth10,
              ],
            ),
          ),
          appSpaces.spaceForHeight20,
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: Container(
                          padding:const EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                          child: content  // content body for each screen
                        ),
                      ),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 78,
                        width: 78,
                        decoration: BoxDecoration(
                            color:headerIconBg,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child:headerImage!=null? Image.asset(
                         headerImage!,
                          height: 38,
                        ):headerIcon
                        )

                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      bottomSheet: bottomSheet,
    );
  }
}
