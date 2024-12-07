import 'dart:math';
import 'package:flutter/material.dart';


Color getRandomColor(){
  Random random = Random();

  Color randomColor = Color.fromRGBO(
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
    1,
  );
  // List<Color> colors = [
  //   Colors.redAccent, Colors.teal,
  //   Colors.green, Colors.grey,
  //   Colors.deepOrange, Colors.deepPurpleAccent,
  //   Colors.amber,Colors.yellow,Colors.purple,Colors.pink];
  //
  // int colorIndex = random.nextInt(colors.length);
  // Color randomColor = colors[colorIndex];
  return randomColor;
}