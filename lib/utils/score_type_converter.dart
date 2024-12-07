

getScoreDouble({required String? score}){
 if(score != null){
   return double.parse(score.toString());
 }else{
   return 0;
 }
}

