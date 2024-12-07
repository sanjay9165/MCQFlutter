import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../core/cubits/QP_completed_exam_cubit/QP_completed_exam_cubit.dart';
import '../../core/cubits/QP_pending_cubit/QP_pending_cubit.dart';
import '../../core/cubits/completed_exam_cubit/completed_exam_cubit.dart';
import '../../core/cubits/pending_cubit/pending_cubit.dart';
import '../../manager/color_manager.dart';


submitDialog({required BuildContext context,
  required double percentage,
  required int subId,
  /// THIS CHAPTER ID WILL BE EXAM ID IN IS NOT MCQ
  required int chapId,
  required bool isMcq}){
  return showDialog(
     barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          surfaceTintColor: Colors.white,
          content: SizedBox(
            height: 450,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Lottie.asset(
                      appImages.congrats,
                      height: 150,
                      width: 300
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: SimpleCircularProgressBar(
                          size: 100,
                          valueNotifier: ValueNotifier(percentage),
                          backColor: Colors.grey.withOpacity(0.2),
                          backStrokeWidth: 25,
                          progressStrokeWidth: 20,
                          mergeMode: true,
                          progressColors: [
                            appColors.brandDark.withOpacity(0.5),
                            appColors.brandDark,
                          ],
                          onGetText: (double value) {
                            TextStyle centerTextStyle = TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: appColors.brandDark,
                            );

                            return Text(
                              '${value.toInt()}%',
                              style: centerTextStyle,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("Success is not final, failure is not fatal:"
                        " It is the courage to continue that counts.",
                      style: appFonts.f16w600Black,
                    textAlign: TextAlign.center,),
                  ),

                CustomButton(
                  width: 120,
                    title: "Review Answers",
                    onTap: (){
                      Get.close(2);
                      if(isMcq) {
                        BlocProvider.of<PendingCubit>(context).getPending(subId: subId.toString());
                        BlocProvider.of<CompletedExamCubit>(context).getCompletedExams(
                            subId: subId.toString());
                        Get.toNamed('/Review',arguments:{"subId":subId.toString(),"chapId":chapId.toString(),"percentage":percentage.toString()});

                      }else{
                        BlocProvider.of<QPPendingCubit>(context).getPending(
                            subId: subId.toString());
                        BlocProvider.of<QPCompletedExamCubit>(context).getCompletedExams(
                            subId: subId.toString());
                        Get.toNamed('/Review',arguments:{"subId":subId.toString(),"examId":chapId.toString(),"percentage":percentage.toString()});

                      }

                    }
                ),
                CustomButton(
                    width: 120,
                    isBorderButton: true,
                    title: "Back",
                    onTap: (){
                      Get.close(2);
                      if(isMcq) {
                        BlocProvider.of<PendingCubit>(context).getPending(subId: subId.toString());
                        BlocProvider.of<CompletedExamCubit>(context).getCompletedExams(
                            subId: subId.toString());
                      }else{
                        BlocProvider.of<QPPendingCubit>(context).getPending(
                            subId: subId.toString());
                        BlocProvider.of<QPCompletedExamCubit>(context).getCompletedExams(
                            subId: subId.toString());
                      }
                    }
                ),
              ],
            ),
          ),
        );
      }
  );
}