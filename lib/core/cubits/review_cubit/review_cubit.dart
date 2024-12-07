import 'package:bloc/bloc.dart';
import 'package:mcq/core/cubits/review_cubit/review_state.dart';
import 'package:mcq/core/repositories/review_repo.dart';

class ReviewCubit extends Cubit<ReviewState>{
  final ReviewRepo reviewRepo ;
  ReviewCubit({required this.reviewRepo}):super(ReviewInitialState());

  Future<void>getReviewResult({required String subId,required String chapId})async{
    emit(ReviewFetchLoadingState());
    final errorOrSuccess=await reviewRepo.getReview(subId: subId, chapId: chapId);
    if(errorOrSuccess.isRight){
      emit(ReviewFetchSuccessState(reviewResult: errorOrSuccess.right));
    }else{
      emit(ReviewFetchErrorState());
    }
  }
  Future<void>getQpReviewResult({required String subId,required String examId})async{
    emit(ReviewFetchLoadingState());
    final errorOrSuccess=await reviewRepo.getQpReview(subId: subId,examId: examId);
    if(errorOrSuccess.isRight){
      emit(ReviewFetchSuccessState(reviewResult: errorOrSuccess.right));
    }else{
      emit(ReviewFetchErrorState());
    }
  }
}