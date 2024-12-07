import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:mcq/core/app_urls.dart';
import 'package:mcq/core/models/QP_subjects_model.dart';
import 'package:mcq/core/models/completed_exam_model.dart';
import 'package:mcq/core/models/completed_qp_model.dart';
import 'package:mcq/core/models/mcq_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/error_snackBar.dart';
import '../models/QP_pending_exam_model.dart';
import '../models/chapter_model.dart';

class McqRepo {
  Future<Either<String, List<McqModel>>> getMcqQuestions(
      {required String gradeId,
      required String subId,
      required String chapId}) async {
    try {
      final response = await http.post(baseUrl(endPoint: 'mcqexamsquestions'),
          body: jsonEncode(
              {"grade_id": gradeId, "sub_id": subId, "chap_id": chapId}),
          headers: headers);
      if (response.statusCode == 200) {
        List<McqModel> mcqModelQuestions =
            McqModel.fromList(jsonDecode(response.body)["data"]);
        return Right(mcqModelQuestions);
      } else {
        if (kDebugMode) {
          print('=====error after getting response ${response.body}');
        }
        return const Left('Something wrong Please try again');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return const Left('Something wrong Please try again');
    }
  }

  Future<Either<String, double>> submitStudentAns(
      List<Map<String, dynamic>> answers) async {
    try {
      print("selected answers ==============================================="
          "=========${answers.toString()}");
      final response = await http.post(baseUrl(endPoint: "submitmcq"),
          headers: headers, body: jsonEncode({"responses": answers}));

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        final accuracy = jsonDecode(response.body)['accuracy_percentage'];
        return Right(double.parse(accuracy.toString()));
      } else {
        if (kDebugMode) {
          print(
              '============error after response${jsonDecode(response.body)} the status code${response.statusCode}');
        }
        return const Left('Something Wrong Please Try Again');
      }
    } catch (e) {
      if (kDebugMode) {
        print('============error before response $e');
      }
      return const Left('Something wrong');
    }
  }

  Future<List<ChaptersModel>> searchChapter({required String value}) async {
    try {
      final response = await http.post(baseUrl(endPoint: "searchchap"),
          headers: headers, body: jsonEncode({"chapter_name": value}));

      if (kDebugMode) {
        print(
            '============RESPONSE OF searchChapter  ${jsonDecode(response.body)["pendingExams"]}');
      }

      final List<ChaptersModel> list =
          ChaptersModel.fromList(jsonDecode(response.body)["data"]);
      return list;
    } catch (e) {
      errorSnackBar();
      if (kDebugMode) {
        print('============error searchChapter $e');
      }
      return [];
    }
  }

  Future<List<ChaptersModel>> getPendingExams({required String subId}) async {
    try {
      final response = await http.post(baseUrl(endPoint: "pending-exams"),
          headers: headers, body: jsonEncode({"sub_id": subId}));

      if (kDebugMode) {
        print(
            '============RESPONSE OF getPendingExams  ${jsonDecode(response.body)["pendingExams"]}');
      }

      final List<ChaptersModel> list =
          ChaptersModel.fromList(jsonDecode(response.body)["pendingExams"]);
      return list;
    } catch (e) {
      errorSnackBar();
      if (kDebugMode) {
        print('============error before response $e');
      }
      return [];
    }
  }

  Future<List<QpExamsModel>> getQPPendingExams({required String subId}) async {
    try {
      final response = await http.post(
          baseUrl(endPoint: "pending-question-exams"),
          headers: headers,
          body: jsonEncode({"sub_id": subId}));

      if (kDebugMode) {
        print('============RESPONSE OF getQPPendingExams'
            '  ${jsonDecode(response.body)["pendingExams"]}');
      }

      final List<QpExamsModel> list =
          QpExamsModel.fromList(jsonDecode(response.body)["pendingExams"]);
      return list;
    } catch (e) {
      errorSnackBar();
      if (kDebugMode) {
        print('============error before response $e');
      }
      return [];
    }
  }

  Future<bool> reportMcqQuestion(
    Map<String, dynamic> details,
  ) async {
    try {
      var request =
          http.MultipartRequest('POST', baseUrl(endPoint: 'reportmcq'));
      request.headers.addAll(headers!);
      request.fields['ques_id'] = details['ques_id'];
      request.fields['marked_answer'] = details['marked_answer'];
      request.fields['correct_answer'] = details['correct_answer'];
      request.fields['description'] = details['description'];
      request.fields['is_ques'] = details['isQuestion'].toString();
      if (details['file'] != null) {
        request.files.add(
            await http.MultipartFile.fromPath("file", details['file'].path));
      }
      var response = await request.send();

      if (response.statusCode == 201) {
        return true;
      }
      if (kDebugMode) {
        var responseData = await http.Response.fromStream(response);
        print(responseData.statusCode);
        print(details);
        print('============error after response ${responseData.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('============error before response $e');
      }
    }
    return false;
  }

  Future<CompletedExamsModel> getCompletedExams({required String subId}) async {
    try {
      final response = await http.post(baseUrl(endPoint: "completed-exams"),
          headers: headers, body: jsonEncode({"sub_id": subId}));

      if (kDebugMode) {
        print(
            '============RESPONSE OF getCompletedExamsExams  ${jsonDecode(response.body)["completedExams"]}');
      }

      final CompletedExamsModel completedExams =
          CompletedExamsModel.fromJson(jsonDecode(response.body));
      return completedExams;
    } catch (e) {
      errorSnackBar();
      if (kDebugMode) {
        print('============error getCompletedExams response $e');
      }
      return CompletedExamsModel();
    }
  }

  Future<Either<String, List<CompletedQpExams>>> getAllCompleteQpExams(
      {required String subId}) async {
    try {
      final response = await http.post(
          baseUrl(endPoint: "completed-question-exams"),
          headers: headers,
          body: jsonEncode({"sub_id": subId}));

      if (response.statusCode == 200) {
        List<CompletedQpExams> allCompletedQpExams = CompletedQpExams.fromList(
            jsonDecode(response.body)['completedExams']);
        return Right(allCompletedQpExams);
      } else {
        if (kDebugMode) {
          print(
              '============error getCompletedExams response ${response.body}');
          return const Left('Something Wrong');
        }
      }
    } catch (e) {
      errorSnackBar();
      if (kDebugMode) {
        print('============error getCompletedExams response $e');
      }
    }
    return const Left('Something Wrong');
  }

  ///
  Future<QpSubjectModel> getQPSubjects() async {
    try {
      final response = await http.get(
        baseUrl(endPoint: "questionpapersubject"),
        headers: headers,
      );

      if (kDebugMode) {
        print(
            '============RESPONSE OF questionpapersubject  ${jsonDecode(response.body)}');
      }
      final QpSubjectModel subjectModel =
          QpSubjectModel.fromJson(jsonDecode(response.body));
      return subjectModel;
    } catch (e) {
      errorSnackBar();
      if (kDebugMode) {
        print('============error questionpapersubject response $e');
      }
      return QpSubjectModel();
    }
  }

  // Future<List<ExamModel>> getExamsList({required String subId}) async {
  //
  //   try {
  //     final response = await http.get(
  //         baseUrl(endPoint: "questionpaperexams/$subId"),
  //         headers: headers,
  //     );
  //
  //     if (kDebugMode) {
  //       print('============ID ===== ${subId} RESPONSE OF getExamsList  ${jsonDecode(response.body)}');
  //     }
  //
  //     final List<ExamModel> exams = ExamModel.fromList(
  //         jsonDecode(response.body)["exams"]);
  //     return exams;
  //
  //   } catch (e) {
  //     errorSnackBar();
  //     if (kDebugMode) {
  //       print('============error getExamsList response $e');
  //     }
  //     return [];
  //   }
  // }

  Future<List<McqModel>> getQPMCQ({required String examId}) async {
    try {
      final response = await http.get(
        baseUrl(endPoint: "questionpapermcq/$examId"),
        headers: headers,
      );

      if (kDebugMode) {
        print('============RESPONSE OF getQPMCQ  ${jsonDecode(response.body)}');
      }

      final List<McqModel> mcqList =
          McqModel.fromList(jsonDecode(response.body)["mcqs"]);
      return mcqList;
    } catch (e) {
      errorSnackBar();
      if (kDebugMode) {
        print('============error getQPMCQ response $e');
      }
      return [];
    }
  }

  Future<bool> reportQp(
    Map<String, dynamic> details,
  ) async {
    try {
      var request =
          http.MultipartRequest('POST', baseUrl(endPoint: 'reportquestion'));
      request.headers.addAll(headers!);
      request.fields['ques_id'] = details['ques_id'];
      request.fields['marked_answer'] = details['marked_answer'];
      request.fields['correct_answer'] = details['correct_answer'];
      request.fields['description'] = details['description'];
      request.fields['is_ques'] = details['isQuestion'].toString();
      if (details['file'] != null) {
        request.files.add(
            await http.MultipartFile.fromPath("file", details['file'].path));
      }
      var response = await request.send();

      if (response.statusCode == 201) {
        return true;
      }
      if (kDebugMode) {
        var responseData = await http.Response.fromStream(response);
        print(responseData.statusCode);
        print(details);
        print('============error after response ${responseData.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('============error before response $e');
      }
    }
    return false;
  }

  Future<Either<String, double>> submitQp(
      List<Map<String, dynamic>> answers) async {
    try {
      print(
          "selected answers in submitQp ==============================================="
          "=========${answers.toString()}");
      final response = await http.post(
          baseUrl(endPoint: "submitquestionpaperexam"),
          headers: headers,
          body: jsonEncode({"responses": answers}));

      if (response.statusCode == 200) {
        print(response.body);
        final accuracy = jsonDecode(response.body)['accuracy_percentage'];
        return Right(double.parse(accuracy.toString()));
      } else {
        if (kDebugMode) {
          print(
              '============error after response${jsonDecode(response.body)} the status code${response.statusCode}');
        }
        return const Left('Something Wrong Please Try Again');
      }
    } catch (e) {
      if (kDebugMode) {
        print('============error before response $e');
      }
      return const Left('Something wrong');
    }
  }
}


///I/flutter ( 6032): selected answers ========================================================
///[{ques_id: 770, response:  ಮಧ್ಯ ಪೂರ್ವಶಿಲಾಯುಗದ ಕಾಲ },
///{ques_id: 771, response:  ಆದಮ್ ಘರ್ }, {ques_id: 772, response: A &B},
///\ {ques_id: 773, response:  ಟೇಲರ್ }, {ques_id: 774, response:  ಮಹಾದಹಾ },
///{ques_id: 775,
///response:  ಚೋಪಾನಿ ಮಾಂಡೋ }, {ques_id: 776, response:  ಲಂಗ್ನಾಜ್},
///{ques_id: 777, response:  ಪ್ರಾಚೀನ-ಐತಿಹಾಸಿಕ ಯುಗ },
///{ques_id: 778, response:  ನರ್ಮದಾ ಕಣಿವೆ },
/// {ques_id: 779, response:  ಜೋಳ },
/// {ques_id: 780, response:  ಟೋಕ್ವಾ},
/// {ques_id: 781, response:  ಮೆಹರ್ ಘರ್},
/// {ques_id: 782, response:  ಮೆಹರ್ ಘರ್},
/// {ques_id: 783, response:  ಮೆಹರ್ ಘರ್ },
/// {ques_id: 784, response:  ತಾಮ್ರದ ಯುಗ }, {ques_id: 785, response:  ಕೋಟಿಜಿ },
/// {ques_id: 786, response:  ವಿ.ಎಸ್. ವಾಕಂ�