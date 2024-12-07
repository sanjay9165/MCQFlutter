
import 'package:flutter/material.dart';
import 'package:mcq/manager/color_manager.dart';

class CustomSelect extends StatelessWidget {
  const CustomSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 1,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        color: Colors.white,
        shape: const CircleBorder(),
        child: SizedBox(
          width: 30,height: 30,
          child: Icon(Icons.check,color: appColors.brandDark,),
        ),
      ),
    );
  }
}
