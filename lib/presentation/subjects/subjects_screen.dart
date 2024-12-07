import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/core/models/subject_model.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/utils/getColor.dart';

import '../../widgets/home_screen/subject_list.dart';

class SubjectListScreen extends StatelessWidget {
  final List<SubjectModel> subjectList;
  const SubjectListScreen({super.key, required this.subjectList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Subjects",
          style: appFonts.f16w600Black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 190,
            ),
            itemCount: subjectList.length,
            itemBuilder: (context, index) {
              SubjectModel subjectModel = subjectList[index];
              return DashboardSubjectCard(
                  borderColor: getColor(color: subjectList[index].color.toString()),
                  imageUrl: subjectModel.image.toString(),
                  testsDone: "${subjectModel.attemptedChapters.toString()}/"
                      "${subjectModel.totalChapters.toString()} Tests Done",
                  title: subjectModel.name.toString(),
                  score:double.parse(subjectModel.avgScore.toString()) ,
                  onTap: () {
                    Get.toNamed("/PendingAndCompletedScreen", arguments: subjectList[index]);
                  });
              //   SubjectCard(
              //   imageUrl: subjectList[index].image.toString(),
              //   title: subjectList[index].name.toString(),
              //   onTap: (){
              //     Get.toNamed("/PendingAndCompletedScreen",
              //         arguments: subjectList[index]
              //     );
              //   },
              //   //chapter: "Chapter ${subjectList[index].chapNo.toString()}",
              //   borderColor:getColor(color: subjectList[index].color.toString()),
              // );
            }),
      ),
    );
  }
}
