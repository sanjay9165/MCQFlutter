import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../models/QP_subjects_model.dart';
import '../../repositories/mcq_repo.dart';

part 'qp_subjects_state.dart';

class QpSubjectsCubit extends Cubit<QpSubjectsState> {
  final McqRepo repo;

  QpSubjectsCubit({required this.repo}) : super(QpSubjectsInitial());


  getQPSubjects() async{
    emit(QpSubjectsLoading());
    try{
      final QpSubjectModel subjects = await repo.getQPSubjects();
      emit(QpSubjectsLoaded(subjects: subjects));

    }catch(e){
      if (kDebugMode) {
        print("Error in QpSubjectsCubit =$e ");
      }
    }
  }
}
