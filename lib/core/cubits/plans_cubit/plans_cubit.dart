import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mcq/core/models/payment_details.dart';
import 'package:meta/meta.dart';

import '../../models/plan_models.dart';
import '../../repositories/plans_repo.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
 final PlanRepo repo;
  PlansCubit({required this.repo}) : super(PlansInitial());

 /// GETTING ALL AVAILABLE PLANS
  Future<void>getPlans()async{
    emit(PlansLoading());
  final isSuccess=await  repo.getPlans();
  if(isSuccess.isRight){
    emit(PlansLoaded(planDetails: isSuccess.right));
  }else{
    emit(PlansError(error: isSuccess.left));
  }
  }

  /// PAYMENT
Future<void> paymentSection({required String amount})async{

}

/// CHECKING USER HAVE A PLAN OR NOT
Future<void>checkUserPlan()async{

}
Future<void>initiatePayment({required String planId})async{
    emit(PlanInitiationLoadingState());
    final isSuccess=await repo.initiatePayment(planId: planId);
    if(isSuccess.isRight){
      emit(PlanInitiationSuccessState(paymentDetails: isSuccess.right));
    }else{
      emit(PlanInitiationErrorState(error: isSuccess.left));
    }
}
Future<void>paymentStarting({required PaymentDetails paymentDetails,required String planId,required String? referralCode})async{
    emit(PlanTransactionLoadingState());
    final isSuccess= await repo.paymentStarting(paymentDetails: paymentDetails,planId: planId,referralId: referralCode);
  if(isSuccess==null){
    emit(PlanTransactionSuccessState());
  }else{
    emit(PlanTransactionErrorState(error: isSuccess));
  }
  }

  Future<void>checkReferralCodeIsValid({required String referralCode})async{
    emit(ReferralCodeCheckLoadingState());
    final isSuccess=await repo.checkReferralCodeIsValid(referralCode: referralCode);
    if(isSuccess.isRight){
      emit(ReferralCodeCheckSuccessState(isValid: isSuccess.right));
    }
    else{
      emit(ReferralCodeCheckErrorState(error: isSuccess.left));
    }
  }
  Future<void>fetchInviteCode()async{
    emit(FetchInviteCodeLoadingState());
    final isSuccess=await repo.fetchInviteCode();
    if(isSuccess.isRight){
      emit(FetchInviteCodeSuccessState(inviteCodeDetails: isSuccess.right));
    }else{
      emit(FetchInviteCodeErrorState(error: isSuccess.left));
    }
  }
}
