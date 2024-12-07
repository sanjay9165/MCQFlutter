
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_state.dart';
import 'package:mcq/core/repositories/profile_repo.dart';
import 'package:mcq/widgets/custom_snackBar.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) :super(ProfileInitial());

  Future<void> getStudentDetail() async {
    emit(ProfileLoadingState());
    final errorOrData = await profileRepo.getStudentDetail();
    if (errorOrData.isRight) {
      emit(ProfileSuccessState(studentModel: errorOrData.right));
    } else {
      emit(ProfileErrorState());
    }
  }

  Future<void> updateStudentDetail({required dynamic id, required Map<String, dynamic>updateData}) async {
    final errorOrData = await profileRepo.updateStudentDetails(id: id, updatedData: updateData);
    if (errorOrData.isRight) {
      Get.back();
      customSnackBar(title: 'Success', message: 'Updated Successfully');
      emit(ProfileSuccessState(studentModel: errorOrData.right));
    } else {
      customSnackBar(title: 'Error', message: 'Something wrong', isError: true);
    }
  }

  Future<void> fetchUserBankDetails() async {
    emit(BankDetailsFetchLoadingState());
    final isSuccess = await profileRepo.fetchUserBankDetails();
    if (isSuccess.isRight) {
      emit(BankDetailsFetchSuccessState(bankDetails: isSuccess.right));
    } else {
      emit(BankDetailsFetchErrorState(error: isSuccess.left));
    }
  }
  Future<void>addOrEditBankDetails({required Map<String,dynamic>details})async{
    emit(AddBankDetailsLoadingState());
    final isSuccess=await profileRepo.addOrEditBankDetails(details: details);
    if(isSuccess.isRight){
      emit(AddBankDetailsSuccessState(bankDetails: isSuccess.right));
    }else{
      emit(AddBankDetailsErrorState(error: isSuccess.left));
    }
  }

  Future<void>checkingEmailAndPhoneMatch({required String email,required String phone})async{
    emit(ForgotPasswordLoadingState());
    final isSuccess=await profileRepo.checkingEmailAndPhoneMatch(email: email, phone: phone);
    if(isSuccess.isRight){
      emit(ForgotPasswordSuccessState(isMatched: isSuccess.right));
    }else{
      emit(ForgotPasswordErrorState());
    }
  }

  Future<void>resetPassword({required String newPassword,required int phone})async{
    emit(ResetPasswordLoadingState());
    bool isSuccess=await profileRepo.resetPassword(newPassword: newPassword, phone: phone);
    if(isSuccess){
      emit(ResetPasswordSuccessState());
    }else{
      emit(ResetPasswordErrorState());
    }
  }

}

