part of 'plans_cubit.dart';

@immutable
abstract class PlansState {}

class PlansInitial extends PlansState {}

class PlansFetchState extends PlansState{}

class PlansLoading extends PlansFetchState {}

class PlansLoaded extends PlansFetchState {
  final PlanDetails planDetails;
  PlansLoaded({required this.planDetails});
}
class PlansError extends PlansFetchState {
  final String error;

  PlansError({required this.error});

}

class PlanPaymentState extends PlansState{
}
class PlanPaymentLoadingState extends PlanPaymentState{}

class PlanPaymentSuccessState extends PlanPaymentState{}

class PlanPaymentVerifyingState extends PlanPaymentState{}

class PlanPaymentErrorState extends PlanPaymentState{
  final String error;

  PlanPaymentErrorState({required this.error});
}

/// THIS STATES FOR INITIATE PAYMENT
class PlanInitiateState extends PlansState{}

class PlanInitiationSuccessState extends PlanInitiateState{
  final PaymentDetails paymentDetails;

  PlanInitiationSuccessState({required this.paymentDetails});
}
class PlanInitiationLoadingState extends PlanInitiateState{

}
class PlanInitiationErrorState extends PlanInitiateState{
 final String error;

  PlanInitiationErrorState({required this.error});
}

/// THIS STATES FOR PAYMENT TRANSACTION
class PlanTransactionState extends PlansState{}

class PlanTransactionSuccessState extends PlanTransactionState{}

class PlanTransactionLoadingState extends PlanTransactionState{}

class PlanTransactionErrorState extends PlanTransactionState{
  final String error;

  PlanTransactionErrorState({required this.error});
}

/// THIS STATES FOR CHECK REFERRAL CODE
class ReferralCodeCheckState extends PlansState{

}
class ReferralCodeCheckSuccessState extends ReferralCodeCheckState{
final bool isValid;

  ReferralCodeCheckSuccessState({required this.isValid});
}

class ReferralCodeCheckLoadingState extends ReferralCodeCheckState{

}

class ReferralCodeCheckErrorState extends ReferralCodeCheckState{
final String error;

  ReferralCodeCheckErrorState({required this.error});
}

/// THIS STATES FOR FETCH INVITE CODE (FOR INVITE FRIENDS SCREEN)
class FetchInviteCodeState extends PlansState{}

class FetchInviteCodeSuccessState extends FetchInviteCodeState{
  final Map<String,dynamic>inviteCodeDetails;

  FetchInviteCodeSuccessState({required this.inviteCodeDetails});
}
class FetchInviteCodeErrorState extends FetchInviteCodeState{
  final String error;

  FetchInviteCodeErrorState({required this.error});
}

class FetchInviteCodeLoadingState extends FetchInviteCodeState{

}





