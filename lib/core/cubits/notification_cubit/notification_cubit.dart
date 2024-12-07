import 'package:bloc/bloc.dart';
import 'package:mcq/core/cubits/notification_cubit/notificatioin_state.dart';

import '../../repositories/notification_repo.dart';

class NotificationCubit extends Cubit<NotificationState>{
  final NotificationsRepo notificationRepo;
  NotificationCubit({required this.notificationRepo}):super(NotificationInitial());
  Future<void>getAllNotifications()async{
    final errorOrSuccess=await notificationRepo.getAllNotification();
    if(errorOrSuccess.isRight){
      emit(NotificationFetchSuccessState(allNotifications: errorOrSuccess.right));
    }else{
      emit(NotificationFetchErrorState(error: 'Something Wrong'));
    }
  }
}