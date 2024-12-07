import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mcq/core/models/mcq_model.dart';

import '../../repositories/mcq_repo.dart';

part 'qp_mcq_state.dart';

class QpMcqCubit extends Cubit<QpMcqState> {
  final McqRepo repo;
  QpMcqCubit({required this.repo}) : super(QpMcqInitial());


  getQPMcq({required String examId}) async{
    emit(QpMcqLoading());
    try{
      final List<McqModel> qpMcqList = await repo.getQPMCQ(examId: examId);
      emit(QpMcqLoaded(qpMcq: qpMcqList));
    }catch(e){
      if (kDebugMode) {
        print("ERROR IN QpMcqCubit WHEN CALLED getQPMcq = $e");
      }
    }
  }

}
