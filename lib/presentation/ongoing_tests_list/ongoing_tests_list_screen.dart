import 'package:flutter/material.dart';
import 'package:mcq/manager/font_manager.dart';

import '../../core/models/chapter_model.dart';
import '../../manager/image_manager.dart';
import '../../widgets/home_screen/ongoing_tests_list.dart';

class OngoingTestListScreen extends StatelessWidget {
  final List<ChaptersModel> testList;
  const OngoingTestListScreen({super.key, required this.testList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing Tests",style: appFonts.f16w600Black,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 190,
            ),
            itemCount: testList.length,
            itemBuilder: (context,index){
              return TestCard(
                model:testList[index] ,
                imageUrl: appImages.onBoardingImage,
                title: testList[index].name.toString(),
                chapter: "Chapter ${testList[index].chapNo.toString()}",
                borderColor: Colors.blue,
              );
            }
        ),
      ),
    );
  }
}
