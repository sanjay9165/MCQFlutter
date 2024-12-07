
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mcq/core/cubits/splash_cubit/splash_cubit.dart';
import 'package:mcq/core/cubits/splash_cubit/splash_state.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/manager/space_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted) {
        BlocProvider.of<SplashCubit>(context).checkingUserLoginOrNot();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:BlocConsumer<SplashCubit,SplashState>(
        listener: (context, state) {
          print("SATE ============== $state");
          if(state is SplashExistingUserState){
            Get.offAllNamed('/HomeScreen');
          }else if(state is SplashNotExistingUserState){
            Get.offAllNamed('/SignIn');
          }else{
            print(state);
          }
        },
        builder:(context, state) =>  SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
            SizedBox(
              child: Column(children: [
                Image.asset(appImages.logo,height: 300,),
                appSpaces.spaceForHeight25,
                Text('MCQ',style: TextStyle(color: Colors.black.withOpacity(0.9),fontSize: 36),),

              ],),
            )
          ],),
        ),
      )
    );
  }
}
