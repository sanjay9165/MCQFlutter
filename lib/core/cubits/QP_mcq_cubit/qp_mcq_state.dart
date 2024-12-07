part of 'qp_mcq_cubit.dart';

@immutable
abstract class QpMcqState {}

class QpMcqInitial extends QpMcqState {}

class QpMcqLoading extends QpMcqState {}

class QpMcqLoaded extends QpMcqState {
  final List<McqModel> qpMcq;
  QpMcqLoaded({required this.qpMcq});
}

class QpMcqError extends QpMcqState {}
