import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../models/completed_exam_model.dart';
import '../../repositories/mcq_repo.dart';

part 'completed_exam_state.dart';

class CompletedExamCubit extends Cubit<CompletedExamState> {
  final McqRepo repo;
  CompletedExamCubit({required this.repo}) : super(CompletedExamInitial());

  getCompletedExams({required String subId}) async{
    emit(CompletedExamLoading());
    try{
      final CompletedExamsModel completedExams =
      await repo.getCompletedExams(subId: subId);

      emit(CompletedExamLoaded(completedExams: completedExams));
    }catch(e){
      if (kDebugMode) {
        print("Error in PendingCubit =$e ");
      }

    }
  }
}
