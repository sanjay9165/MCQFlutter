import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../repositories/mcq_repo.dart';
import 'QP_completed_exam_state.dart';


class QPCompletedExamCubit extends Cubit<QPCompletedExamState> {
  final McqRepo repo;
  QPCompletedExamCubit({required this.repo}) : super(QPCompletedExamInitial());

  getCompletedExams({required String subId}) async{

    try{
      final successOrError   = await repo.getAllCompleteQpExams(subId: subId);
      // await repo.getCompletedExams(subId: subId);
     if(successOrError.isRight) {
       emit(QPCompletedExamLoaded(completedExams:successOrError.right ));
     }
    }catch(e){
      if (kDebugMode) {
        print("Error in PendingCubit =$e ");
      }
    }
  }
}
