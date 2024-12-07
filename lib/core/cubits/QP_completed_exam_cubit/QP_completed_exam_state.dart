


import '../../models/completed_qp_model.dart';


abstract class QPCompletedExamState {}

class QPCompletedExamInitial extends QPCompletedExamState {}

class QPCompletedExamLoading extends QPCompletedExamState {}

class QPCompletedExamLoaded extends QPCompletedExamState {
  final List<CompletedQpExams> completedExams;
  QPCompletedExamLoaded({required this.completedExams});
}

class QPCompletedExamError extends QPCompletedExamState {}
