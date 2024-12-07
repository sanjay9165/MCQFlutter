import 'package:flutter/material.dart';
import 'package:mcq/utils/random_color_generator.dart';


Color getColor({required String color}){
  try{
    Color color0 = Color(int.parse(color));
    return color0;
  }catch(e){
    return getRandomColor();
  }
}