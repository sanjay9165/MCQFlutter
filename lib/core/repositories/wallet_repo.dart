import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:mcq/core/app_urls.dart';
import 'package:mcq/core/models/wallet_model.dart';

class WalletRepo{

  Future<Either<String,WalletModel>> getWalletDetails()async{
    try {
      final response=await get(baseUrl(endPoint: 'wallet'),headers: headers);
      if(response.statusCode==200){
        WalletModel walletModel=WalletModel.fromJson(jsonDecode(response.body));
        return Right(walletModel);
      }else{
        if (kDebugMode) {
          print('=================error after response${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
    }
    return const Left('Something wrong please try again');
  }
  Future<String?>claimWalletAmount({required String amount})async{
    try {
      final response=await post(baseUrl(endPoint: 'withdraw'),body:jsonEncode({
        "amount":amount
      }),headers: headers);
      if(response.statusCode==200){
        return null;
      }
      if (kDebugMode) {
        print('=================error after response${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
    }
    return 'Something Wrong Please Try again';
  }

}