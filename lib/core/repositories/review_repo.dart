import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mcq/core/app_urls.dart';
import 'package:mcq/core/models/review_model.dart';

class ReviewRepo {
  Future<Either<String, List<ReviewModel>>> getReview(
      {required String subId, required String chapId}) async {
    try {
      final response = await http.post(baseUrl(endPoint: 'review'),
          headers: headers, body: json.encode({"sub_id": subId, "chap_id": chapId}));
      if(response.statusCode==200){
        List<ReviewModel> reviewResults =
        ReviewModel.fromList(jsonDecode(response.body)["report"]);
        return Right(reviewResults);
      }else{
        print('===after=============error on${response.body}');
        return const Left('Something wrong');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return const Left('Something wrong');
    }
  }
  Future<Either<String, List<ReviewModel>>> getQpReview(
      {required String subId,required String examId,}) async {
    try {
      final response = await http.post(baseUrl(endPoint: 'questionpaperreview'),
          headers: headers, body: json.encode({"sub_id": subId,"exam_id":examId}));
      if(response.statusCode==200){
        List<ReviewModel> reviewResults =
        ReviewModel.fromList(jsonDecode(response.body)["report"]);
        return Right(reviewResults);
      }else{
        print('===after=============error on${response.body}');
        return const Left('Something wrong');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return const Left('Something wrong');
    }
  }
}
