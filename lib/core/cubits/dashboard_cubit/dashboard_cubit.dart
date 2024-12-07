import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mcq/core/models/dashboard_model.dart';

import '../../repositories/profile_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final ProfileRepo repo;
  DashboardCubit({required this.repo}) : super(DashboardInitial());

  getData()async{
    emit(DashboardLoading());
    try{
     final DashBoardModel data =  await repo.getDashboardData();
     emit(DashboardLoaded(data: data));
    }catch(e){
      if (kDebugMode) {
        print("ERROR IN DashboardCubit =$e ");
      }
    }
  }
}
