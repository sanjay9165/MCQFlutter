import 'package:flutter/material.dart';
import 'package:mcq/manager/color_manager.dart';


AppFonts appFonts = AppFonts();

class AppFonts{

  TextStyle f10w400Grey = const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.black
  );

  TextStyle f10w700Black = const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: Colors.black
  );

  TextStyle f12w400Grey = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.grey
  );

  TextStyle f12w600 = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: appColors.brandDark
  );

  TextStyle f12w600Grey = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.grey
  );

  TextStyle f12w600Black = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black
  );

  TextStyle f14w400White = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white
  );

  TextStyle f14w400Grey = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey
  );

  TextStyle f14w600Grey = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.grey
  );

  TextStyle f14w600Black = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);

  TextStyle f14w800Black = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black);

  TextStyle f16w600White = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

  TextStyle f16w600 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: appColors.brandDark);

  TextStyle f16w700White = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

  TextStyle f20w600Black = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 0.7);

  TextStyle f20w700White = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);

  TextStyle f19w600Black = const TextStyle(
      color: Colors.black,
      fontSize: 19,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8);

  TextStyle f18w500Black =
      const TextStyle(color: Colors.black, fontSize: 18, letterSpacing: 0.8);

  TextStyle f16w600Black = const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.7);

  TextStyle f17w600Black = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.7,
      color: Colors.black);
  TextStyle f15w600Grey = const TextStyle(
      color: Colors.grey,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.7);
 TextStyle f21w1000Black=const TextStyle(color: Colors.black,fontSize: 21,fontWeight: FontWeight.bold,letterSpacing: 1);

  TextStyle f14w600BrandDark= TextStyle(
  color: appColors
      .brandDark,
  fontSize: 14,
  fontWeight:
  FontWeight.w600);
}
