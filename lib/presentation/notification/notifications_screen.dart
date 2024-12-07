import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mcq/core/cubits/notification_cubit/notificatioin_state.dart';
import 'package:mcq/core/cubits/notification_cubit/notification_cubit.dart';
import 'package:mcq/core/models/notification_model.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/space_manager.dart';

import '../../core/models/mcq_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {

    super.initState();
    BlocProvider.of<NotificationCubit>(context).getAllNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.brandDark,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child:const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.white,
            )),
        title: Text(
          'Notifications',
          style: appFonts.f20w700White,
        ),
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
          buildWhen: (previous, current) => current is NotificationFetchState,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NotificationFetchSuccessState) {
              List<NotificationModel> allNotifications = state.allNotifications.reversed.toList();

              return allNotifications.isNotEmpty
                  ? RefreshIndicator(
                color: appColors.brandDark,
                displacement: 50,
                    onRefresh: ()async {
                      BlocProvider.of<NotificationCubit>(context).getAllNotifications();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: ListView.builder(
                          itemCount: allNotifications.length,
                          itemBuilder: (context, index) {
                            NotificationModel notification=allNotifications[index];
                          late  ReportedModel reportedDetails;
                          late  McqModel reportedQuestion;
                            if (notification.ismcq == 1) {
                              reportedDetails = notification.reportedMcqQues??ReportedModel();
                              reportedQuestion = notification.reportedMcqQuesMcq??McqModel();
                            } else {
                              reportedDetails = notification.reportedQuesPaper??ReportedModel();
                              reportedQuestion = notification.reportedQuesPaperMcq??McqModel();
                            }
                            List<String> options = [
                              reportedQuestion.option1 ?? '',
                              reportedQuestion.option2 ?? '',
                              reportedQuestion.option3 ?? '',
                              reportedQuestion.option4 ?? ''
                            ];
                        return   Container(
                             margin:const EdgeInsets.only(bottom: 12,left: 5,right:5,top: 5),
                           padding: const EdgeInsets.all(9),

                             width: double.infinity,
                             decoration: BoxDecoration(
                               color: Colors.white,
                                   borderRadius: BorderRadius.circular(12),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.black.withOpacity(0.3),
                                       blurRadius: 3,
                                       spreadRadius: 1
                                     )
                                 ]
                             ),
                          child: Column(children: [
                            Text(notification.message??'',textAlign: TextAlign.center,style: appFonts.f17w600Black.copyWith(color: appColors.brandDark),),
                            const Divider(),
                            Text('Reported Question',style: appFonts.f14w600Black,),
                            appSpaces.
                          spaceForHeight10,
                            Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(minHeight: 50),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5),borderRadius: BorderRadius.circular(8)),
                              child: Text(reportedQuestion.question??''),
                            ),
                            appSpaces.spaceForHeight10,
                            Text('Options',style: appFonts.f14w600Black,),
                          Column(
                            children: [
                              ...List.generate(4, (index) {


                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 10,
                                    backgroundColor:options[index]!=reportedQuestion.correct? Colors.black.withOpacity(0.6):Colors.green,
                                  ),
                                  title: Text(
                                  options[index],
                                    style: appFonts.f16w600Black,
                                  ),
                                );
                              }),
                          ]
                          ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //   GestureDetector(
                            //     onTap: () {
                            //
                            //     },
                            //     child: Row(children: [
                            //       Text('Mark as Seen',style: appFonts.f14w600BrandDark,),
                            //       appSpaces.spaceForWidth10,
                            //      Text('>>>',style: appFonts.f14w600BrandDark,)
                            //     ],),
                            //   )
                            // ],)
                            ]
                           )
                        );
                          },
                        ),
                    ),
                  )
                  : Center(
                      child: Text(
                        'No Notifications To Show',
                        style: appFonts.f17w600Black.copyWith(color: appColors.brandDark),
                      ),
                    );
            } else if (state is NotificationFetchErrorState) {
              return Center(
                child: Text(
                  'Error On Fetching Notification Please Try Again',
                  style: appFonts.f17w600Black.copyWith(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
