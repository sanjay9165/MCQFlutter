import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:mcq/core/models/payment_details.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../utils/error_snackBar.dart';
import '../app_urls.dart';
import '../models/plan_models.dart';

class PlanRepo {
  Future<Either<String, PlanDetails>> getPlans() async {
    try {
      final response = await get(baseUrl(endPoint: 'plans'), headers: headers);
      if (response.statusCode == 200) {
        // List<PlanModel> plans = PlanModel.fromList(json.decode(response.body)['plans']);
        PlanDetails planDetails =
            PlanDetails.fromJson(json.decode(response.body));
        return Right(planDetails);
      }
      if (kDebugMode) {
        print("Response After Getting Plans = "
            "${json.decode(response.body)}");
      }
      return const Left('Something wrong');
    } catch (e) {
      if (kDebugMode) {
        print("ERROR After Getting Plans = "
            "$e");
      }
      errorSnackBar();
      return const Left('Something Wrong');
    }
  }

  Future<bool> checkUserPlan() async {
    try {} catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
    }
    return false;
  }

  /// INITIATE PAYMENT FROM BACKEND
  Future<Either<String, PaymentDetails>> initiatePayment(
      {required String planId}) async {
    try {
      final response = await get(baseUrl(endPoint: 'initiate-payment/$planId'),
          headers: headers);
      if (response.statusCode == 200) {
        PaymentDetails paymentDetails =
            PaymentDetails.fromJson(jsonDecode(response.body));
        return Right(paymentDetails);
      } else {
        String error = jsonDecode(response.body)['error'];
        return Left(error);
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return const Left('Something went wrong');
    }
  }

  /// PAYMENT STARTING
  Future<String?> paymentStarting(
      {required PaymentDetails paymentDetails,
      required String planId,
      required String? referralId}) async {
    print('funtion  called');
    print('verned ${paymentDetails.response!.id}');
    try {
      Razorpay razorpay = Razorpay();
      // print(dotenv.env['DEV_RAZORPAY_KEY_ID']);
      // print(dotenv.env['PROD_RAZORPAY_KEY_ID']);
      String key =
          dotenv.env[isDev ? 'DEV_RAZORPAY_KEY_ID' : 'PROD_RAZORPAY_KEY_ID']!;
      Map<String, dynamic> paymentOptions = {
        'key': key,
        'amount': paymentDetails.response!.amount,
        'name': 'MCQ',
        'order_id': paymentDetails.response!.id,
        'description': 'Description for order',
        'timeout': 60,
        'prefill': {
          'contact': paymentDetails.userMobile,
          'email': 'adinansayed@gmail.com',
          // 'contact': 8111857749,
          // 'email': 'adinansayed@gmail.com'
        },
      };
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) async {
        final backendResponse = await post(baseUrl(endPoint: 'payment-update'),
            headers: headers,
            body: jsonEncode({
              'r_payment_id': response.paymentId,
              'r_order_id': response.orderId,
              'method': "response",
              'currency': 'INR',
              'amount': paymentDetails.response!.amount,
              "plan_id": int.parse(planId),
              'json_response': jsonEncode({
                "razorpay_payment_id": response.paymentId,
                "razorpay_order_id": response.orderId,
                "razorpay_signature": response.signature
              })
            }));
        print('this one is that ${int.parse(planId)}');
        print('this is the bod ${backendResponse.body}');
        if (backendResponse.statusCode == 200) {
          /// APPLYING REFERRAL
          if (referralId != null) {
            await applyReferralCode(referralCode: referralId);
          }
          customSnackBar(title: 'Success', message: 'Subscription completed');
          Get.back();
          return;
        } else {
          print(backendResponse.statusCode);
          // print(response.)
        }
      });
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        print('erro is there ${response.error}');
        customSnackBar(
            title: 'Errorerrrrrrrrrrrrrrr',
            message:
                response.message ?? 'Something went wrong Please try again',
            isError: true);
      });
      razorpay.on(
          Razorpay.EVENT_EXTERNAL_WALLET, (PaymentSuccessResponse response) {});
      razorpay.open(paymentOptions);
    } catch (e) {
      print('atleast');
      if (kDebugMode) {
        print('=================error on$e');
      }
      return 'Something wrong $e';
    }
    return null;
  }

  Future<Either<String, bool>> checkReferralCodeIsValid(
      {required String referralCode}) async {
    try {
      final response = await post(
          Uri.parse("${appUrls.networkUrl}api/verify-invite-code"),
          body: jsonEncode({"invite_code": referralCode}),
          headers: headers);
      if (response.statusCode == 200) {
        int status = jsonDecode(response.body)['status'];
        return Right(status == 1);
      } else {
        if (kDebugMode) {
          print('=================error after response${response.body}');
        }
        return const Left('Something Wrong Please try again');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return const Left('Something Wrong Please try again');
    }
  }

  Future<bool> applyReferralCode({required String referralCode}) async {
    try {
      final response = await post(baseUrl(endPoint: 'verify-invite'),
          body: jsonEncode({'invite_code': referralCode}), headers: headers);
      if (response.statusCode == 200) {
        return true;
      }
      if (kDebugMode) {
        print('=================error after response${response.body}');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return false;
    }
  }

  /// FETCH INVITE CODE
  Future<Either<String, Map<String, dynamic>>> fetchInviteCode() async {
    try {
      final response =
          await get(baseUrl(endPoint: 'invitecode'), headers: headers);
      if (response.statusCode == 200) {
        return Right(jsonDecode(response.body));
      }
      if (kDebugMode) {
        print('=================error after response${response.body}');
      }
      return const Left('Something Wrong Please Try again');
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
    }
    return const Left('Something went wrong Please Try again');
  }
}
