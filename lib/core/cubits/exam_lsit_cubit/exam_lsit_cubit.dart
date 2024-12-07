// import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';
// import 'package:mcq/core/models/chapter_model.dart';
// import 'package:mcq/core/models/exam_model.dart';
// import 'package:mcq/core/repositories/mcq_repo.dart';
// import 'package:meta/meta.dart';
//
// part 'exam_lsit_state.dart';
//
// class ExamListCubit extends Cubit<ExamListState> {
//   final McqRepo repo;
//   ExamListCubit({required this.repo}) : super(ExamListInitial());
//
//
//   getExamList({required String subId})async{
//
//     emit(ExamListLoading());
//     try{
//       final List<ExamModel> exams = await repo.getExamsList(
//           subId: subId);
//       emit(ExamListLoaded(exams: exams));
//     }catch(e){
//       if (kDebugMode) {
//         print("Error in ExamListCubit =$e");
//       }
//     }
//   }
//
// }
