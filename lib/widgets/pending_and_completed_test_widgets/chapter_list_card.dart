import 'package:flutter/material.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';

import '../../core/models/QP_pending_exam_model.dart';
import '../../core/models/chapter_model.dart';
import '../../manager/color_manager.dart';

class ChapterCard extends StatefulWidget {
  final String title;
  final String chapterNumber;
  final ChaptersModel? model;
  final QpExamsModel? qpPendingExamsModel;
  const ChapterCard(
      {super.key, required this.title, required this.chapterNumber, this.model, this.qpPendingExamsModel});

  @override
  State<ChapterCard> createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard> {
 late bool isLocked;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.model!=null){
      isLocked=widget.model!.isLocked==1;
    }else{
      isLocked=widget.qpPendingExamsModel!.isLocked==1;
    }
  }
  @override
  Widget build(BuildContext context) {

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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: Image.asset(
                  appImages.chapter,
                  height: 35,
                  width: 35,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth(context)-130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.model != null ? "Chapter" : ""} ${widget.chapterNumber}",
                          style: appFonts.f12w400Grey,
                        ),
                        isLocked ? Icon(Icons.lock,size: 30,color: Colors.black.withOpacity(0.8),) : const SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(
                      width: screenWidth(context) * 0.65,
                      child: Text(
                        widget.title,
                        style: appFonts.f12w600Black.copyWith(color: isLocked ? Colors.grey : Colors.black),
                        overflow: TextOverflow.ellipsis,
                      )),
                  SizedBox(
                    height: 40,
                    child: SliderButton(
                      buttonColor: Colors.grey,
                      width: 150,
                      dismissible: false,
                      backgroundColor: isLocked ? Colors.grey : appColors.brandDark,
                      action: () {
                        if(!isLocked) {
                          Get.toNamed("/McqListScreen",
                              arguments: {"subject": widget.title, "chapterModel": widget.model, "examModel": widget.qpPendingExamsModel});
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior:SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(15),
                                backgroundColor: appColors.brandDark,
                                  content: const Text('Please Subscribe to Unlock')));
                        }
                        },
                      label: const Text(
                        ">>>>",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      child: Container(
                        height: 30,
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Center(
                            child: Text(
                          "Start",
                          style: appFonts.f12w600,
                        )),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
