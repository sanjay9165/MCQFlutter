part of 'qp_subjects_cubit.dart';

@immutable
abstract class QpSubjectsState {}

class QpSubjectsInitial extends QpSubjectsState {}

class QpSubjectsLoading extends QpSubjectsState {}

class QpSubjectsLoaded extends QpSubjectsState {
  final QpSubjectModel subjects;
  QpSubjectsLoaded({required this.subjects});
}

class QpSubjectsError extends QpSubjectsState {}
