import 'package:flutter/material.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;

  final Function() onTap;
  final bool? isBorderButton;
  final Color? backGroundColor;
  final TextStyle? textStyle;
  const CustomButton({super.key, required this.title, this.width,
    required this.onTap, this.height, this.isBorderButton, this.backGroundColor, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: MaterialButton(
        color: isBorderButton ?? false ? Colors.white : backGroundColor??
        appColors.brandDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(31),
          side: isBorderButton ?? false ?
              BorderSide(
                color: appColors.brandDark
              ) :
              BorderSide.none
        ),
          onPressed: onTap,

        child: SizedBox(
          height: height ?? 45,
          width: width ?? getDimension(context: context,horizontalPadding: 15).w,
          child: Center(child: Text(title,
            style:isBorderButton ?? false ?
            appFonts.f16w600 :
            textStyle??appFonts.f16w600White,)),
        ),
      ),
    );
  }
}
