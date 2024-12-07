part of 'registrations_cubit.dart';

@immutable
abstract class RegistrationsState {}

class RegistrationsInitial extends RegistrationsState {}

class RegistrationsLoading extends RegistrationsState {}


class RegisterSuccessState extends RegistrationsState{
  final Map<String,dynamic>userDetails;

  RegisterSuccessState({required this.userDetails});
}

class RegisterErrorState extends RegistrationsState{
  final String error;
  RegisterErrorState({required this.error});
}


class RegistrationsGradesLoaded extends RegistrationsState {
  final List<GradeModel> grades;
  RegistrationsGradesLoaded({required this.grades});
}

class RegistrationsError extends RegistrationsState {}

/// THIS STATES FOR SIGN IN PAGE
class SignInState extends RegistrationsState{

}

class SignInLoadingState extends SignInState{

}
class SignInSuccessState extends SignInState{

}
class SignInErrorStateState extends SignInState{

}

