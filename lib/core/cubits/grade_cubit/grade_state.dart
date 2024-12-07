part of 'grade_cubit.dart';

@immutable
abstract class GradeState {}

class GradeInitial extends GradeState {}
class GradeLoading extends GradeState {}
class GradeLoaded extends GradeState {
  final List<GradeModel> grades;
  GradeLoaded({required this.grades});
}
