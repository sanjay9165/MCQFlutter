part of 'pending_cubit.dart';

@immutable
abstract class PendingState {}

class PendingInitial extends PendingState {}

class PendingLoading extends PendingState {}

class PendingLoaded extends PendingState {
  final List<ChaptersModel> pendingExams;
  PendingLoaded({required this.pendingExams});
}

class PendingError extends PendingState {}