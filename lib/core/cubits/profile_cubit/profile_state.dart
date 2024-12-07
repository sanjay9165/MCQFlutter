

import 'package:mcq/core/models/student_model.dart';

import '../../models/bank_details_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState{}


/// THIS STATS FOR FETCHING STUDENT DETAILS
class ProfileFetchState extends ProfileState{}

class ProfileSuccessState extends ProfileFetchState{
  final StudentModel studentModel;
  ProfileSuccessState({required this.studentModel});
}
class ProfileErrorState extends ProfileFetchState{

}

class ProfileLoadingState extends ProfileFetchState{

}
/// THIS STATS FOR UPDATING STUDENT DETAILS
class ProfileUpdateState extends ProfileState{}

class ProfileUpdateErrorState extends ProfileUpdateState{}

class ProfileUpdateLoadingState extends ProfileUpdateState{}

/// THIS STATES FOR FETCHING BANK DETAILS OF USERS (WALLET BALANCE SCREEN)
class BankDetailsFetchState extends ProfileState{}

class BankDetailsFetchSuccessState extends BankDetailsFetchState{
  final BankDetailsModel? bankDetails;

  BankDetailsFetchSuccessState({required this.bankDetails});
}
class BankDetailsFetchErrorState extends BankDetailsFetchState{
  final String error;

  BankDetailsFetchErrorState({required this.error});
}

class BankDetailsFetchLoadingState extends BankDetailsFetchState{}

/// THIS STATES FOR ADDING AND EDITING BANK DETAILS (add bank details screen)

class AddBankDetailsState extends ProfileState{}

class AddBankDetailsSuccessState extends AddBankDetailsState{
  final Map<String,dynamic>bankDetails;

  AddBankDetailsSuccessState({required this.bankDetails});
}
class AddBankDetailsErrorState extends AddBankDetailsState{
  final String error;

  AddBankDetailsErrorState({required this.error});
}
class AddBankDetailsLoadingState extends AddBankDetailsState{}


/// THIS STATES FOR FORGOT PASSWORD
class ForgotPasswordState extends ProfileState{}

class ForgotPasswordSuccessState extends ForgotPasswordState{
  /// TO CHECK PASSWORD AND EMAIL IS MATCH
 final bool isMatched;

  ForgotPasswordSuccessState({required this.isMatched});
}

class ForgotPasswordErrorState extends ForgotPasswordState{

 String? error;

  ForgotPasswordErrorState({this.error});
}

class ForgotPasswordLoadingState extends ForgotPasswordState{}

/// RESET PASSWORD STATES
 class ResetPasswordState extends ProfileState{}

class ResetPasswordSuccessState extends ResetPasswordState{}

class ResetPasswordErrorState extends ResetPasswordState{
  String ?error;
  ResetPasswordErrorState([this.error]);
}

class ResetPasswordLoadingState extends ResetPasswordState{}





