import '../../models/review_model.dart';

abstract class ReviewState{

}
class ReviewInitialState extends ReviewState{}

class ReviewBuildState extends ReviewState{}

class ReviewFetchSuccessState extends ReviewBuildState{
  final List<ReviewModel>reviewResult;

  ReviewFetchSuccessState({required this.reviewResult});
}
class ReviewFetchErrorState extends ReviewBuildState{}
class ReviewFetchLoadingState extends ReviewBuildState{}
