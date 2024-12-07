
import '../../models/QP_pending_exam_model.dart';


abstract class QPPendingState {}

class QPPendingInitial extends QPPendingState {}

class QPPendingLoading extends QPPendingState {}

class QPPendingLoaded extends QPPendingState {
  final List<QpExamsModel> pendingExams;
  QPPendingLoaded({required this.pendingExams});
}

class QPPendingError extends QPPendingState {}