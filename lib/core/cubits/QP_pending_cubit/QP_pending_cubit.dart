import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../models/QP_pending_exam_model.dart';
import '../../repositories/mcq_repo.dart';
import 'QP_pending_state.dart';

class QPPendingCubit extends Cubit<QPPendingState> {
  final McqRepo repo;
  QPPendingCubit({required this.repo}) : super(QPPendingInitial());

  getPending({required String subId}) async{
  emit(QPPendingLoading());
    try{
    final List<QpExamsModel> pendingExams =
    await repo.getQPPendingExams(subId: subId);

    emit(QPPendingLoaded(pendingExams: pendingExams));
    }catch(e){

      if (kDebugMode) {
        print("Error in PendingCubit =$e ");
      }
    }
  }
}
