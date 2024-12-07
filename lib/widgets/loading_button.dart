
import 'package:flutter/material.dart';

import '../manager/color_manager.dart';
import '../manager/font_manager.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    this.height,
    this.width, this.borderRadius,
  });
  final double? height;
  final double? width;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 12),
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: appColors.brandDark,
        borderRadius: BorderRadius.circular(borderRadius??12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'wait',
              style: appFonts.f14w400White,
            ),
            const SizedBox(height: 23, width: 23, child: CircularProgressIndicator(color: Colors.white,))
          ],
        ),
      ),
    );
  }
}
