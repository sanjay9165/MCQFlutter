import 'package:flutter/material.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:get/get.dart';
import 'package:mcq/core/app_urls.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/utils/getColor.dart';

import '../../core/models/chapter_model.dart';
import '../custom_network_image.dart';

class OngoingTestsList extends StatelessWidget {
  final List<ChaptersModel> models;
  const OngoingTestsList({super.key, required this.models});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:models.isNotEmpty? 210:70,
      child:models.isNotEmpty? ListView.builder(
        itemCount: models.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,index){
          return TestCard(
            model: models[index],
            imageUrl:getImageUrl(endPoint:models[index].subject !=null?
            models[index].subject!.image.toString() : ""),
            title: models[index].name.toString(),
            chapter: "Chapter ${models[index].chapNo.toString()}",
            borderColor: getColor(color:models[index].subject !=null?
            models[index].subject!.color.toString() : ""),
          );
        },
      ): Center(child: Text('No Ongoing Tests',style: appFonts.f14w600BrandDark,),),
    );
  }
}



class TestCard extends StatelessWidget {
  final Color borderColor;
  final String imageUrl;
  final String chapter;
  final String title;
  final ChaptersModel model;
  const TestCard({super.key, required this.borderColor,
    required this.imageUrl, required this.chapter, required this.title, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 170,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border:   Border.all(
          color: borderColor,
        ),
        boxShadow:  [
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              url: imageUrl,
              height: 50,
            ),
            //Image.asset(imageUrl,height: 50,),

            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(chapter,style: appFonts.f12w400Grey,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              model.isLocked==1?  const Icon(Icons.lock,color: Colors.black,):const SizedBox()
              ],
            ),
            Text(title,style: appFonts.f12w600Black,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 40,
              child: SliderButton(
                width: 150,
                dismissible: false,
                backgroundColor:  model.isLocked==1?Colors.grey: appColors.brandDark,
                action: () {
                  if(model.isLocked==1){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            behavior:SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(15),
                            backgroundColor: appColors.brandDark,
                            content: const Text('Please Subscribe to Unlock')));
                  }else {
                    Get.toNamed("/McqListScreen", arguments: {
                      "subject": title,
                      "chapterModel": model
                    });
                  }
                },
                label: const Text(
                  ">>>>",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
                ),
                child: Container(
                  height: 30,
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Center(child: Text("Start",style: appFonts.f12w600,)),
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
