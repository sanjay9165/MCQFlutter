import '../../models/mcq_model.dart';

abstract class McqState {}

class McqInitialState extends McqState{}


class McqQuestionsLoadingState extends McqState{

}
class McqQuestionsSuccessState extends McqState{
 final List<McqModel>mcqQuestions;

  McqQuestionsSuccessState(this.mcqQuestions);

}

class McqQuestionsErrorState extends McqState{

}
class McqQuestionOptionsState extends McqState{
 int index=5;
 McqQuestionOptionsState(this.index);
}




