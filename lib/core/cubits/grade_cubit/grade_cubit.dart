import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mcq/core/repositories/profile_repo.dart';

import '../../models/grade_model.dart';
part 'grade_state.dart';


///TODO: USE IN ADMIN
class GradeCubit extends Cubit<GradeState> {
  final ProfileRepo repo;
  GradeCubit({required this.repo}) : super(GradeInitial());

  getGrade() async{
    emit(GradeLoading());
    try{
      List<GradeModel> grades = await repo.getGrades();

      emit(GradeLoaded(grades: grades));

    }catch(e){
      if (kDebugMode) {
        print("ERROR GETTING GRADES = $e");
      }
    }
  }

}
