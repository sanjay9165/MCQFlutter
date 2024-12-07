import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mcq/core/cubits/splash_cubit/splash_state.dart';
import '../../app_urls.dart';

class SplashCubit extends Cubit<SplashState>{
  SplashCubit():super(SplashInitialState());

 void checkingUserLoginOrNot(){
   Future.delayed(const Duration(seconds: 3));
   final box = GetStorage();

   String? accessToken=box.read('token');
   if(accessToken!=null){
     headers!["authorization"]="Bearer $accessToken";
     emit(SplashExistingUserState());
   }else{
     emit(SplashNotExistingUserState());
   }

}
}