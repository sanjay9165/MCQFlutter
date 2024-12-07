import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/core/app_urls.dart';
import 'package:mcq/utils/getColor.dart';

import '../../core/models/subject_model.dart';
import '../../manager/font_manager.dart';
import '../../utils/score_color.dart';
import '../custom_network_image.dart';

class SubjectsList extends StatelessWidget {
  final List<SubjectModel> subjects;
  const SubjectsList({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        itemCount: subjects.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return DashboardSubjectCard(
            onTap: () {
              print(subjects[index]);
              Get.toNamed("/PendingAndCompletedScreen",
                  arguments: subjects[index]);
            },
            imageUrl: subjects[index].image.toString(),
            title: subjects[index].name.toString(),
            testsDone: "${subjects[index].attemptedChapters.toString()}/"
                "${subjects[index].totalChapters.toString()} Tests Done",
            borderColor:
                getColor(color: subjects[index].attemptedChapters.toString()),
            score: subjects[index].avgScore != null
                ? double.parse(subjects[index].avgScore.toString())
                : 0,
          );
        },
      ),
    );
  }
}

class DashboardSubjectCard extends StatelessWidget {
  final Color borderColor;
  final String imageUrl;
  final String testsDone;
  final String title;
  final double score;
  final Function onTap;
  const DashboardSubjectCard(
      {super.key,
      required this.borderColor,
      required this.imageUrl,
      required this.testsDone,
      required this.title,
      required this.score,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(imageUrl);
        onTap();
      },
      child: Container(
        height: 180,
        width: 130,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: borderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.8),
              blurRadius: 8,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.network(
              //     height: 48, getImageUrl(endPoint: imageUrl)),
              CustomNetworkImage(
                url: imageUrl,
                height: 48,
              ),
              // Image.asset(
              //   imageUrl,
              //   height: 70,
              // ),

              const SizedBox(
                height: 5,
              ),

              Text(
                title,
                style: appFonts.f12w600Black,
                textAlign: TextAlign.center,
              ),
              Text(
                testsDone,
                style: appFonts.f10w400Grey,
                textAlign: TextAlign.center,
              ),
              LinearProgressIndicator(
                value: score / 100,
                minHeight: 10,
                borderRadius: BorderRadius.circular(6),
                color: scoreColor(score: score),
              ),
              Text(
                "Average Score $score %",
                style: appFonts.f10w700Black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
