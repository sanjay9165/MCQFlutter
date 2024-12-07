import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:mcq/core/app_urls.dart';
import 'package:mcq/core/models/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationsRepo{
  Future<Either<String,List<NotificationModel>>>getAllNotification()async{
    try {
      final response=await http.get(baseUrl(endPoint: 'notifications'),headers: headers);

      if(response.statusCode==200){
        List<NotificationModel>allNotification=NotificationModel.fromList(jsonDecode(response.body)['notifications']);
        return Right(allNotification);
      }
      else{
        if (kDebugMode) {
          print('=================error after response${response.body}');
        }
        return const Left('Something Wrong');
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      return Left(e.toString());
    }
  }
}