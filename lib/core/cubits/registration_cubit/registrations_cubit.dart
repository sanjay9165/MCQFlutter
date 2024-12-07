import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import 'package:safe_device/safe_device.dart';
import '../../models/grade_model.dart';
import '../../repositories/profile_repo.dart';
part 'registrations_state.dart';

class RegistrationsCubit extends Cubit<RegistrationsState> {
  final ProfileRepo repo;
  RegistrationsCubit({required this.repo}) : super(RegistrationsInitial());

  getGrades() async {
    emit(RegistrationsLoading());
    try {
      await repo
          .getGrades()
          .then((grades) => emit(RegistrationsGradesLoaded(grades: grades)));
    } catch (e) {
      if (kDebugMode) {
        print("ERROR in getting grades ==$e");
      }
      emit(RegistrationsError());
    }
  }

  registerStudent({required StudentModel studentModel}) async {
    emit(RegistrationsLoading());

    final isSuccess = await repo.registerStudent(studentModel: studentModel);
    print('from here $isSuccess');
    if (isSuccess.isRight) {
      emit(RegisterSuccessState(userDetails: isSuccess.right));
    } else {
      emit(RegisterErrorState(error: isSuccess.left));
    }
    //     .then((status) {
    //   customSnackBar(
    //       title: 'Registration Success', message: 'Your Registration Completed Please Login with Email and Password');
    //   Get.offAllNamed("/SignIn");
    // });
    // } catch (e) {
    //   if (kDebugMode) {
    //     print("ERROR in getting grades ==$e");
    //   }
    //   emit(RegistrationsError());
    // }
  }

  loginStudent({required StudentModel studentModel,required bool verified}) async {
    // emit(RegistrationsLoading());
    emit(SignInLoadingState());
    try {
      await repo
          .loginStudent(verified: verified,
        studentModel: studentModel,
      )
          .then((status) async {
        if (status) {
          bool isRealDevice = await SafeDevice.isRealDevice;
          if (isRealDevice) {
            /// CHECKING THE PHONE NUMBER IS VALID
            bool isValid = await repo.phoneNumberValidation(
                phoneNumber: studentModel.phoneNo!);
            print(studentModel.phoneNo);
            print(isValid);
            if (isValid) {
              Get.offAllNamed("/HomeScreen");
            } else {
              final box = GetStorage();
              await box.remove('token');
              customSnackBar(
                  title: 'Invalid Number',
                  isError: true,
                  message: "The selected number is wrong");
            }
          } else {
            Get.offAllNamed("/HomeScreen");
          }
        }
      });
      emit(SignInState());
    } catch (e) {
      if (kDebugMode) {
        print("ERROR during login ==$e");
      }
      emit(RegistrationsError());
    }
  }
}
