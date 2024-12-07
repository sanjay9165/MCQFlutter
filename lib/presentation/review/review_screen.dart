import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mcq/core/cubits/review_cubit/review_cubit.dart';
import 'package:mcq/core/cubits/review_cubit/review_state.dart';
import 'package:mcq/core/models/review_model.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import 'package:mcq/widgets/custom_appBar.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.subId, required this.chapId, required this.percentage, this.examId});
  final String subId;
  /// THIS FIELD MAY BE CHAP ID OR EXAM ID
  final String? chapId;
  final String ? examId;
  final String percentage;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.chapId != null) {
      BlocProvider.of<ReviewCubit>(context).getReviewResult(subId: widget.subId, chapId: widget.chapId!);
    } else {
      BlocProvider.of<ReviewCubit>(context).getQpReviewResult(subId: widget.subId,examId: widget.examId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            children: [
              appSpaces.spaceForHeight20,
              const CustomAppBar(title: 'Review'),
              appSpaces.spaceForHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You're Right",
                    style: appFonts.f16w600Black,
                  ),
                  appSpaces.spaceForWidth10
                ],
              ),
              Text(
                "${double.parse(widget.percentage).toInt().toString()}%",
                style: appFonts.f16w600,
              ),
              appSpaces.spaceForHeight20,
              Expanded(
                child: SizedBox(
                  height: screenHeight(context) - 150,
                  child: BlocConsumer<ReviewCubit, ReviewState>(
                      listener: (context, state) {},
                      buildWhen: (previous, current) => current is ReviewBuildState,
                      builder: (context, state) {
                        if (state is ReviewFetchLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ReviewFetchErrorState) {
                          return const Center(
                            child: Text('Something Wrong Please Try Again'),
                          );
                        } else if (state is ReviewFetchSuccessState) {
                          List<ReviewModel> reviewResult = state.reviewResult;
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                AnimationLimiter(
                                  child: ResponsiveGridList(
                                      listViewBuilderOptions: ListViewBuilderOptions(
                                          shrinkWrap: true, physics: const NeverScrollableScrollPhysics()),
                                      minItemWidth: 87,
                                      horizontalGridSpacing: 25,
                                      children: List.generate(reviewResult.length, (index) {
                                        bool isAnsValid =
                                            reviewResult[index].response == reviewResult[index].question!.correct!.trim();
                                        return AnimationConfiguration.staggeredGrid(
                                          position: index,
                                          duration: const Duration(milliseconds: 375),
                                          columnCount: screenWidth(context) ~/ 90,
                                          child: ScaleAnimation(
                                            child: FadeInAnimation(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.toNamed('/ReviewShowScreen', arguments: {
                                                    "reviewResults": reviewResult,
                                                    "percentage": widget.percentage,
                                                    "currentQuestion": index + 1,
                                                    "isChapter": widget.chapId != "-1" ? true : false
                                                  });
                                                },
                                                child: Container(
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1)],
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            isAnsValid ? Colors.green : Colors.red.withOpacity(0.9),
                                                        child: Center(
                                                          child: Icon(
                                                            !isAnsValid ? Icons.close : Icons.check,
                                                            color: Colors.white,
                                                            size: 28,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Question ${index + 1}',
                                                        style: appFonts.f14w600Black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      ),
                                  ),
                                ),
                                appSpaces.spaceForHeight25,
                                CustomButton(
                                  title: 'Answers',
                                  onTap: () {
                                    Get.toNamed('/ReviewShowScreen', arguments: {
                                      "reviewResults": reviewResult,
                                      "percentage": widget.percentage,
                                      "isChapter": widget.chapId != "-1" ? true : false
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
