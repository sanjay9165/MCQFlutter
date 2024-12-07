import 'dart:async';
import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mcq/core/models/dashboard_model.dart';
import 'package:mcq/core/models/grade_model.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/presentation/home/home_screen.dart';
import 'package:mcq/presentation/otp_screen/otp_screen.dart';
import '../../utils/error_snackBar.dart';
import '../../widgets/custom_snackBar.dart';
import '../app_urls.dart';
import '../models/bank_details_model.dart';

class ProfileRepo {
  Future<List<GradeModel>> getGrades() async {
    try {
      final response = await http.get(
          Uri.parse("${appUrls.networkUrl}api/get-grades"),
          headers: headers);

      List<GradeModel> grades = GradeModel.fromList(json.decode(response.body));
      if (kDebugMode) {
        print("=============Response After Getting grades = "
            "${json.decode(response.body)}");
      }

      return grades;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR After Getting grades = "
            "$e");
      }
      errorSnackBar();
      return [];
    }
  }

  Future<Either<String, Map<String, dynamic>>> registerStudent(
      {required StudentModel studentModel}) async {
    print('object');
    final phone = int.parse(studentModel.phoneNo!);
    try {
      final response = await http.post(baseUrl(endPoint: 'register'),
          body: json.encode({
            "name": studentModel.name,
            "phone_no": phone,
            "password": studentModel.password
          }),
          headers: headers);
      print("response after registrations === ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        print('this also worked');
        // Get.toNamed("/SignIn", arguments: studentModel);
        return Right(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        final mailError = jsonDecode(response.body)['errors']['email'];
        final phoneError = jsonDecode(response.body)['errors']['phone_no'];
        if (mailError != null) {
          return Left(mailError.first);
        } else if (phoneError != null) {
          return Left(phoneError.first);
        } else {
          return const Left('Validation Failed');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR IN registerStudent == $e");
      }
      // customSnackBar(
      //     title: "ERROR",
      //     message: "Something Went Wrong. Please Try Again Later",
      //     isError: true);
    }

    return const Left('Something wrong please try again');
  }

  Future<bool> loginStudent(
      {required StudentModel studentModel, required bool verified}) async {
    print('work');
    try {
      final response = await http.post(baseUrl(endPoint: 'login'),
          body: json.encode({
            "phone_no": studentModel.phoneNo,
            "password": studentModel.password,
          }),
          headers: headers);
      if (response.statusCode == 200) {
        print('successfully api called in login');
        if (verified) {
          print('verified');
          final token = jsonDecode(response.body)["access_token"];
          // print(token);
          headers!["authorization"] = "Bearer $token";
          final box = GetStorage();
          box.write('token', token);
          return true;
        } else {
          print('not verif');
          Get.to(OtpScreen(
              phone: int.parse(studentModel.phoneNo!),
              studentModel: studentModel,
              isLogin: true,
              resetPasswordOrNot: false));
          return true;
        }

        // Get.offAllNamed("/HomeScreen");
      }
      final token = jsonDecode(response.body)["access_token"];
      final error = jsonDecode(response.body)["error"];

      if (kDebugMode) {
        print("response after registrations === ${jsonDecode(response.body)}");
      }

      if (token != null) {
        // accessToken = token;
        return true;
      } else if (error != null) {
        customSnackBar(
            title: "SignIn Failed", message: error.toString(), isError: true);
        return false;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR IN login == $e");
      }
      errorSnackBar();
      return false;
    }
  }

  Future<DashBoardModel> getDashboardData() async {
    try {
      final response =
          await http.get(baseUrl(endPoint: 'dashboard'), headers: headers);
      // final response = await http.get(uri, headers: headers);
      DashBoardModel data = DashBoardModel.fromJson(json.decode(response.body));
      if (kDebugMode) {
        print("Response After  getDashboardData = "
            "${json.decode(response.body)}");
      }

      return data;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR After Getting getDashboardData = "
            "$e");
      }
      errorSnackBar();
      return DashBoardModel();
    }
  }

  Future<Either<String, StudentModel>> getStudentDetail() async {
    try {
      final response =
          await http.get(baseUrl(endPoint: 'profile'), headers: headers);
      if (response.statusCode == 200) {
        StudentModel studentModel =
            StudentModel.fromJson(jsonDecode(response.body));
        return Right(studentModel);
      } else {
        if (kDebugMode) {
          print(
              '==========error after getting the response error ${response.body}');
        }

        return const Left('Something wrong');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return const Left('Something wrong');
    }
  }

  Future<Either<String, StudentModel>> updateStudentDetails(
      {required dynamic id, required Map<String, dynamic> updatedData}) async {
    try {
      final response = await http.put(baseUrl(endPoint: 'update/$id'),
          body: jsonEncode(updatedData), headers: headers);
      if (response.statusCode == 200) {
        print('200=========${response.body}');
        return Right(StudentModel.fromJson(jsonDecode(response.body)['user']));
      } else {
        if (kDebugMode) {
          print(
              '==========error after getting the response error ${response.body}');
        }

        return const Left('Something wrong');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return const Left('Something wrong');
    }
  }

  Future<Either<String, BankDetailsModel?>> fetchUserBankDetails() async {
    try {
      final response =
          await get(baseUrl(endPoint: 'bank-details'), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['bank_details'];
        BankDetailsModel? bankDetails;
        if (data.isNotEmpty) {
          bankDetails = BankDetailsModel.fromJson(data.first);
        }
        return Right(bankDetails);
      }
      if (kDebugMode) {
        print('=================error after response${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
    }
    return const Left('Something Wrong Please Try Again');
  }

  /// FOR ADDING OR EDIT USER BANK DETAILS (add bank details screen)
  Future<Either<String, Map<String, dynamic>>> addOrEditBankDetails(
      {required Map<String, dynamic> details}) async {
    try {
      final response = await post(baseUrl(endPoint: 'bank-details'),
          headers: headers, body: jsonEncode(details));
      if (response.statusCode == 200) {
        return Right(jsonDecode(response.body)['bank_details']);
      }
      if (kDebugMode) {
        print('=================error after response${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
    }
    return const Left('Something Wrong Please Try Again');
  }

  Future<bool> phoneNumberValidation({required String phoneNumber}) async {
    // try {
    //   final response =
    //       await http.get(baseUrl(endPoint: 'profile'), headers: headers);
    //   if (response.statusCode == 200) {
    //     print('called');
    //     StudentModel studentModel =
    //         StudentModel.fromJson(jsonDecode(response.body));
    //     if (studentModel.phoneNo == phoneNumber ||
    //         studentModel.phoneNo == "3333333333") {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   }
    // } catch (e) {
    //   if (kDebugMode) {
    //     print('=================error on$e');
    //   }
    // }
    return true;
  }

  /// FOR FORGOT PASSWORD (CHECKING EMAIL AND PASSWORD IS MATCHING)
  Future<Either<String, bool>> checkingEmailAndPhoneMatch(
      {required String email, required String phone}) async {
    try {
      final response = await post(
          Uri.parse("${appUrls.networkUrl}api/verify-user"),
          body: {"email": email, "phone_no": phone});
      if (response.statusCode == 200) {
        int status = jsonDecode(response.body)['status'];
        return Right(status == 1);
      } else {
        if (kDebugMode) {
          print('=================error on${response.body}');
        }
        return const Left('Something went wrong');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return const Left('Something went wrong');
    }
  }

  /// FOR RESET PASSWORD
  Future<bool> resetPassword(
      {required String newPassword, required int phone}) async {
    print('reacched');
    try {
      final response = await post(
          // Uri.parse(
          //   uri,
          Uri.parse(
            "https://mcq.teqsuit.com/api/forgotpassword",
          ),
          body: {"phone_no": phone.toString(), "new_password": newPassword});
      if (response.statusCode == 200) {
        print('this one');
        String newToken = jsonDecode(response.body)['token'];
        headers!['authorization'] = "Bearer $newToken";
        final box = GetStorage();
        box.write('token', newToken);
        Get.offAll(const HomeScreen());
        // Get.to
        print(response.body);
        return true;
      }
      print('there is a error');
    } catch (e) {
      print(e);
      if (kDebugMode) {
        print('=================error on$e');
      }
    }
    return false;
  }
}
