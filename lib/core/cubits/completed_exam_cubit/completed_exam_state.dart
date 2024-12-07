part of 'completed_exam_cubit.dart';

@immutable
abstract class CompletedExamState {}

class CompletedExamInitial extends CompletedExamState {}

class CompletedExamLoading extends CompletedExamState {}

class CompletedExamLoaded extends CompletedExamState {
  final CompletedExamsModel completedExams;
  CompletedExamLoaded({required this.completedExams});
}

class CompletedExamError extends CompletedExamState {}
