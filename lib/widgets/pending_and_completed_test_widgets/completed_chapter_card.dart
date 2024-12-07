import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/core/models/chapter_model.dart';
import 'package:mcq/core/models/completed_exam_model.dart';
import 'package:mcq/core/models/completed_qp_model.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';

import '../../manager/color_manager.dart';
import '../../utils/score_color.dart';
import '../../utils/score_type_converter.dart';

class CompletedChapterCard extends StatefulWidget {
  final CompletedExams? completedExams;
  final CompletedQpExams? qpExamsModel;
  const CompletedChapterCard({super.key, this.completedExams, this.qpExamsModel});

  @override
  State<CompletedChapterCard> createState() => _CompletedChapterCardState();
}

class _CompletedChapterCardState extends State<CompletedChapterCard> {
  String? title;
  String? chapterNumber;
  double score = 0.0;
  @override
  Widget build(BuildContext context) {
    if (widget.completedExams != null) {
      title = widget.completedExams!.exam?.name.toString();
      chapterNumber = widget.completedExams!.exam?.chapNo.toString();
      score = getScoreDouble(score: widget.completedExams!.score);
    } else {
      title = widget.qpExamsModel!.completedExams!.examName;
      chapterNumber = widget.qpExamsModel!.completedExams!.examYear;
      score = getScoreDouble(score: widget.qpExamsModel!.score);
    }

    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      surfaceTintColor: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: Image.asset(
                  appImages.chapter,
                  height: 35,
                  width: 35,
                ),
              ),
              SizedBox(
                width: screenWidth(context) * 0.40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chapter $chapterNumber",
                      style: appFonts.f12w400Grey,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: appFonts.f12w600Black,
                    ),
                    appSpaces.spaceForHeight25,
                    SizedBox(
                      width: screenWidth(context) * 0.45,
                      child: LinearProgressIndicator(
                        value: score / 100,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(6),
                        color: scoreColor(score: score),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Average Score $score %",
                      style: appFonts.f10w700Black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.completedExams != null) {
                        Get.toNamed("/McqListScreen", arguments: {
                          "subject": title,
                          "chapterModel": ChaptersModel(
                            subId: widget.completedExams!.exam!.subId,
                            id: widget.completedExams!.exam!.id,
                            chapNo: widget.completedExams!.exam!.chapNo,
                            gradeId: widget.completedExams!.exam!.gradeId,
                            name: widget.completedExams!.exam!.name,
                          ),
                          "examModel": null
                        });
                      } else {
                        Get.toNamed("/McqListScreen",
                            arguments: {"subject": title, "examModel": widget.qpExamsModel!.completedExams});
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: appColors.brandDark),
                      ),
                      child: Center(
                          child: Text(
                        'Attempt',
                        style: appFonts.f12w600Black,
                      )),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (widget.completedExams != null) {
                        Get.toNamed("/Review", arguments: {
                          "subId": widget.completedExams!.exam!.subId.toString(),
                          "chapId": widget.completedExams!.exam!.id.toString(),
                          "percentage": widget.completedExams!.score.toString()
                        });
                      } else {
                        Get.toNamed("/Review", arguments: {
                          "subId": widget.qpExamsModel!.completedExams!.subId.toString(),
                          "examId": widget.qpExamsModel!.completedExams!.id.toString(),
                          "percentage": widget.qpExamsModel!.score.toString()
                        });
                      }
              // Get.toNamed('/Review',arguments:{"subId":subId.toString(),"chapId":chapId.toString(),"percentage":percentage.toString()});
                    },
                    child: Text(
                      "Review >",
                      style: appFonts.f12w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
