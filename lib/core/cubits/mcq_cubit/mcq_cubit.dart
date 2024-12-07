
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mcq/core/cubits/mcq_cubit/mcq_state.dart';
import 'package:mcq/core/models/mcq_model.dart';
import 'package:mcq/core/repositories/mcq_repo.dart';
import 'package:mcq/widgets/mcq_list_widgets/report_success_dialog.dart';
import 'package:mcq/widgets/start_test_widgets/submit_dialog.dart';

import '../../../widgets/custom_snackBar.dart';
import '../../models/review_model.dart';

class McqCubit extends Cubit<McqState> {
 final McqRepo mcqRepo ;
  McqCubit({required this.mcqRepo}) : super(McqInitialState());

  Future<void> getMcqQuestions(
      {required String gradeId, required String subId,
        required String chapId,}) async {
    emit(McqQuestionsLoadingState());

    final errorOrSuccess = await mcqRepo.getMcqQuestions(
        gradeId: gradeId, subId: subId, chapId: chapId);

    if (errorOrSuccess.isRight) {
      emit(McqQuestionsSuccessState(errorOrSuccess.right));
    } else {
      customSnackBar(
          title: "ERROR",
          message: "Something went wrong. Please Try Again Later",
          isError: true);
      emit(McqQuestionsErrorState());
    }
  }
  // for managing the options state
void onChangedOptions(int index){
    emit(McqQuestionOptionsState(index));
}

Future<String?>submitStudentAns(List<Map<String,dynamic>>answers,BuildContext context,int subID,int chapId)async{
final errorOrResponse=await mcqRepo.submitStudentAns(answers);
if(errorOrResponse.isRight){

  submitDialog(context: context, percentage: errorOrResponse.right,subId:subID,chapId: chapId, isMcq: true);
}else{
  customSnackBar(
      title: "ERROR",
      message: "Something went wrong. Please Try Again Later",
      isError: true);
}
return null;


}

Future<void>reportMcqQuestion(Map<String,dynamic>details,BuildContext context)async{
 final isSuccess=await mcqRepo.reportMcqQuestion(details);
 if(isSuccess){
     reportSuccessDialog(context);
     await Future.delayed(const Duration(seconds: 3));
     Get.close(2);
 }else{
   customSnackBar(
       title: "ERROR",
       message: "Something went wrong. Please Try Again Later",
       isError: true);
 }

}

reviewQuestionsAndAnswers(List<ReviewModel>reviewResults){
 List<McqModel>mcqQuestions=   reviewResults.map((e) => e.question!).toList();
    emit(McqQuestionsSuccessState(mcqQuestions));
}
Future<void>getQpMcq({required String examId})async{
  emit(McqQuestionsLoadingState());
    final response=await mcqRepo.getQPMCQ(examId: examId);

    emit(McqQuestionsSuccessState(response));
}
Future<void>reportQp(Map<String,dynamic>details,BuildContext context)async{
  final errorOrSuccess=await mcqRepo.reportQp(details);
  if(errorOrSuccess){
    reportSuccessDialog(context);
    await Future.delayed(const Duration(seconds: 3));
    Get.close(2);
  }else{
    customSnackBar(
        title: "ERROR",
        message: "Something went wrong. Please Try Again Later",
        isError: true);
  }
}

Future<void>submitQp({required List<Map<String,dynamic>>answers,required BuildContext context,required int subId,required int examId})async{

  final errorOrResponse=await mcqRepo.submitQp(answers);
  if(errorOrResponse.isRight){

    submitDialog(context: context, percentage: errorOrResponse.right,subId:subId,chapId:examId,isMcq: false);
  }else{
    customSnackBar(
        title: "ERROR",
        message: "Something went wrong. Please Try Again Later",
        isError: true);
  }
  return;

}

}
