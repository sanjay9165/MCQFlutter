

import 'package:flutter/cupertino.dart';

getDimension({required BuildContext context,double? horizontalPadding, double? verticalPadding}){
  final double horizontalPadding0 = horizontalPadding ?? 0;
  final double verticalPadding0 = verticalPadding ?? 0;
 Dimensions dimensions = Dimensions(
      h:  MediaQuery.of(context).size.height-verticalPadding0,
      w:  MediaQuery.of(context).size.width-horizontalPadding0
  );
 return dimensions;


}
 double screenHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
   }
    double screenWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
   }

class Dimensions{
  final double w;
  final double h;
  Dimensions({required this.h,required this.w});

}