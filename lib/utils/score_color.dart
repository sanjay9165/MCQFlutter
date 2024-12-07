import 'package:flutter/material.dart';

scoreColor({required double score}){
  if(score <=40){
    return const Color(0xffF14747);
  }else if(score >=40 && score <=70){
    return const Color(0xffF3B440);
  }else{
    return const Color(0xff16978C);
  }
}