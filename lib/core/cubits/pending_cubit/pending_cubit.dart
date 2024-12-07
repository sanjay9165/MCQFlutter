import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../models/chapter_model.dart';
import '../../repositories/mcq_repo.dart';
part 'pending_state.dart';

class PendingCubit extends Cubit<PendingState> {
  final McqRepo repo;
  PendingCubit({required this.repo}) : super(PendingInitial());

  getPending({required String subId}) async{
    emit(PendingLoading());
    try{

    final List<ChaptersModel> pendingExams =
    await repo.getPendingExams(subId: subId);
    emit(PendingLoaded(pendingExams: pendingExams));
    }catch(e){
      if (kDebugMode) {
        print("Error in PendingCubit =$e ");
      }
    }
  }
}
