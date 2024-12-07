import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcq/core/cubits/completed_exam_cubit/completed_exam_cubit.dart';
import 'package:mcq/core/cubits/pending_cubit/pending_cubit.dart';
import 'package:mcq/core/models/subject_model.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import '../../core/models/completed_exam_model.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';
import '../../utils/score_color.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/pending_and_completed_test_widgets/chapter_list_card.dart';
import '../../widgets/pending_and_completed_test_widgets/completed_chapter_card.dart';


class PendingAndCompletedScreen extends StatefulWidget {
  final SubjectModel subjectModel;
  const PendingAndCompletedScreen({super.key,
    required this.subjectModel});

  @override
  State<PendingAndCompletedScreen> createState() =>
      _PendingAndCompletedScreenState();
}

class _PendingAndCompletedScreenState extends State<PendingAndCompletedScreen> {
  int selectedIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PendingCubit>(context).getPending(
        subId:widget.subjectModel.id.toString());
    BlocProvider.of<CompletedExamCubit>(context).getCompletedExams(
        subId:widget.subjectModel.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        DefaultTabController(
          length: 2,
          child: ListView(
            children: [
              Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: appColors.brandLite,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(45)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const BackButton(),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: getDimension(context: context,horizontalPadding: 170).w,
                          child: RichText(
                            maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: "Grade ${widget.subjectModel.gradeId}  ",
                                  style: appFonts.f16w600Black,
                                  children: [
                                    TextSpan(
                                        text: widget.subjectModel.name.toString(),
                                        style: appFonts.f20w600Black
                                    )
                                  ]
                              )),
                        ),
                        Text(
                          "chapters ${widget.subjectModel.totalChapters}",
                          style: appFonts.f14w600Grey,),
                        Text("${widget.subjectModel.attemptedChapters}/${
                            widget.subjectModel.totalChapters
                        } Tests Done", style: appFonts.f10w400Grey,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: getDimension(context: context,horizontalPadding: 180).w,
                          child: LinearProgressIndicator(
                            value: widget.subjectModel.avgScore != null ?
                           double.parse( widget.subjectModel.avgScore.toString())/100 :0,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(6),
                            color: scoreColor(score: 89),
                          ),
                        ),
                        Text("Average Score ${widget.subjectModel.avgScore} %", style: appFonts.f10w700Black,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox()
                      ],
                    ),
                    const Spacer(),
                      CustomNetworkImage(url: widget.subjectModel.image.toString(),
                          height: 100,width: 90,),
                   // Image.asset(appImages.onBoardingImage, height: 100,),
                    const SizedBox(width: 15,),
                  ],
                ),
              ),
              TabBar(
                  labelColor: appColors.brandDark,
                  indicatorColor: appColors.brandDark,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  tabs: const[
                    Tab(text: "Pending",),
                    Tab(text: "Completed",),
                  ]),


              selectedIndex == 0 ?
              BlocBuilder<PendingCubit, PendingState>(
                builder: (context, state) {
                  if (state is PendingLoaded) {
                    return SizedBox(
                      height: getDimension(
                          context: context, verticalPadding: 250).h,
                      child:state.pendingExams.isNotEmpty? ListView.builder(
                        itemCount: state.pendingExams.length,
                        itemBuilder: (context, index) {
                          return ChapterCard(
                            title: state.pendingExams[index].name.toString(),
                            chapterNumber: state.pendingExams[index].chapNo
                                .toString(),
                            model:state.pendingExams[index],
                          );
                        },
                      ):Center(child: Text('No Pending Exams In This Subject',style: appFonts.f14w600BrandDark,),),
                    );
                  } else {
                    return const Center(child: Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                },
              ) :
              BlocBuilder<CompletedExamCubit, CompletedExamState>(
                builder: (context, completedExamState) {
                  if (completedExamState is CompletedExamLoaded) {
                    final List<CompletedExams> completedExam = completedExamState.completedExams.completedExams != null ?
                    completedExamState.completedExams.completedExams as  List<CompletedExams> :
                    [];

                    return
                      SizedBox(
                        height: getDimension(
                            context: context, verticalPadding: 250).h,
                        child:completedExam.isNotEmpty? ListView.builder(
                          itemCount: completedExam.length,
                          itemBuilder: (context, index) {
                            return CompletedChapterCard(
                              completedExams: completedExam[index],
                            );
                          },
                        ):Center(child: Text('No Completed Exams In This Subject',style: appFonts.f14w600BrandDark,),),
                      );
                  } else {
                    return const Center(child: Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                },
              ),
            ],
          ),
        )
    );
  }
}
