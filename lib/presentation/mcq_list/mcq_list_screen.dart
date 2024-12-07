import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:mcq/core/cubits/mcq_cubit/mcq_cubit.dart';
import 'package:mcq/core/cubits/mcq_cubit/mcq_state.dart';
import 'package:mcq/core/models/mcq_model.dart';
import 'package:mcq/main.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import 'package:mcq/widgets/custom_button.dart';
import '../../core/cubits/dashboard_cubit/dashboard_cubit.dart';
import '../../core/models/QP_pending_exam_model.dart';
import '../../core/models/chapter_model.dart';
import '../../widgets/mcq_list_widgets/report_dialog.dart';

enum ReviewOrTest { review, test }

class McqListScreen extends StatefulWidget {
  final String subject;
  final ChaptersModel? chapterModel;
  final QpExamsModel? examModel;

  const McqListScreen({
    super.key,
    required this.subject,
    this.chapterModel,
    this.examModel,
  });

  @override
  State<McqListScreen> createState() => _McqListScreenState();
}

class _McqListScreenState extends State<McqListScreen>
    with SingleTickerProviderStateMixin {
  bool? isCheckPending;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late Animation<Offset> _translationAnim;
  late Animation<Offset> _moveAnim;
  late Animation<double> _scaleAnim;
  final key = GlobalKey();
  late Box<Map> box;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);

    Animation<Offset> animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-5.0, 0.0),
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    _translationAnim =
        Tween(begin: const Offset(0.0, -5.0), end: const Offset(-1000.0, 0.0))
            .animate(controller)
          ..addListener(() {
            setState(() {});
          });
    _scaleAnim = Tween(begin: 0.965, end: 1.0).animate(curvedAnimation);
    _moveAnim =
        Tween(begin: const Offset(0.0, -0.05), end: const Offset(0.0, 0.0))
            .animate(curvedAnimation);

    // TODO: implement initState
    super.initState();
    box = Hive.box(boxName);
    if (box.values.isNotEmpty) {
      isCheckPending = false;
    }
    if (widget.chapterModel != null) {
      BlocProvider.of<McqCubit>(context).getMcqQuestions(
          gradeId: widget.chapterModel!.gradeId.toString(),
          subId: widget.chapterModel!.subId.toString(),
          chapId: widget.chapterModel!.id.toString());
    } else {
      BlocProvider.of<McqCubit>(context)
          .getQpMcq(examId: widget.examModel!.id.toString());
    }
  }

  int correctIndex = 0;
  int currentQuestion = 0;
  int currentIndex = 2;
  bool questionSubmit = false;
  bool isAnsValid = true;
  List<Map<String, dynamic>> userResponses = [];
  List<Map<String, dynamic>> options = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        await box.clear();
      },
      child: Scaffold(
        body: SafeArea(
            child: BlocBuilder<McqCubit, McqState>(
                buildWhen: (previous, current) =>
                    current is! McqQuestionOptionsState,
                builder: (context, state) {
                  if (state is McqQuestionsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is McqQuestionsErrorState) {
                    return const Center(
                      child: Text('Something wrong'),
                    );
                  } else if (state is McqQuestionsSuccessState) {
                    List<Color> colors = [
                      appColors.brandDark,
                      appColors.brandDark.withOpacity(0.7),
                      appColors.brandDark.withOpacity(0.5)
                    ];
                    List<McqModel> mcqQuestions = state.mcqQuestions;
                    List<Map> completedQues = box.values.toList();
                    if (isCheckPending != null && !isCheckPending!) {
                      for (var data in completedQues) {
                        log(data.toString());
                        if (completedQues.indexOf(data) != 0) {
                          userResponses.add({
                            "ques_id": data['ques_id'],
                            "response": data['response']
                          });
                        }
                      }
                      _pendingExams(completedQues, mcqQuestions.length);
                    }
                    if (mcqQuestions.length < 3 && currentIndex == 2) {
                      currentIndex = mcqQuestions.length - 1;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            appSpaces.spaceForHeight25,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      box.clear();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                    )),
                                appSpaces.spaceForWidth10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenWidth(context) - 180,
                                      child: Text(
                                        widget.subject,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: appFonts.f21w1000Black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.chapterModel != null
                                          ? "Chapter ${widget.chapterModel!.chapNo}"
                                          : "Year ${widget.examModel!.examYear}",
                                      textAlign: TextAlign.center,
                                      style: appFonts.f15w600Grey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${mcqQuestions.isNotEmpty ? currentQuestion + 1 : 0}/${mcqQuestions.length}',
                                      style: appFonts.f15w600Grey,
                                    ),
                                    appSpaces.spaceForHeight25,
                                  ],
                                ),
                              ],
                            ),
                            appSpaces.spaceForHeight25,
                            mcqQuestions.isNotEmpty
                                ? Animate(
                                    effects: const [
                                      FadeEffect(),
                                      ScaleEffect()
                                    ],
                                    child: Column(
                                      children: [
                                        appSpaces.spaceForHeight10,
                                        SizedBox(
                                          width: double.infinity,
                                          child: Stack(
                                              children: List.generate(
                                                  mcqQuestions.length -
                                                              (currentQuestion) >=
                                                          3
                                                      ? 3
                                                      : mcqQuestions.length -
                                                          (currentQuestion),
                                                  (index) {
                                            return Transform.translate(
                                              offset: _getFlickTransformOffset(
                                                  index),
                                              child: FractionalTranslation(
                                                translation:
                                                    _getStackedCardOffset(
                                                        index),
                                                child: Transform.scale(
                                                  scale: _getStackedCardScale(
                                                      index),
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 19,
                                                          vertical: 20),
                                                      constraints:
                                                          const BoxConstraints(
                                                        minHeight: 180,
                                                      ),
                                                      width:
                                                          screenWidth(context) -
                                                              40,
                                                      // width:index==0?screenWidth(context)-115:index==1?screenWidth(context)-80:screenWidth(context)-30,
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 20,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: colors[
                                                              currentIndex -
                                                                  index],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: index ==
                                                              currentIndex
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    'Question ${currentQuestion + 1}',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    )),
                                                                appSpaces
                                                                    .spaceForHeight20,
                                                                Text(
                                                                  mcqQuestions[
                                                                              currentQuestion]
                                                                          .question ??
                                                                      '',
                                                                  style: appFonts
                                                                      .f16w600White,
                                                                )
                                                              ],
                                                            )
                                                          : const SizedBox()),
                                                ),
                                              ),
                                            );
                                          })),
                                        ),
                                        appSpaces.spaceForHeight20,
                                        BlocConsumer<McqCubit, McqState>(
                                            buildWhen: (previous, current) =>
                                                current
                                                    is McqQuestionOptionsState,
                                            listener: (context, state) {},
                                            builder: (context, state) {
                                              if (!questionSubmit) {
                                                options = [
                                                  {
                                                    'title': mcqQuestions[
                                                                currentQuestion]
                                                            .option1 ??
                                                        '',
                                                    'backGround': Colors.white,
                                                    'border':
                                                        appColors.brandDark,
                                                    'icon': null,
                                                  },
                                                  {
                                                    'title': mcqQuestions[
                                                                currentQuestion]
                                                            .option2 ??
                                                        '',
                                                    'backGround': Colors.white,
                                                    'border':
                                                        appColors.brandDark,
                                                    'icon': null,
                                                  },
                                                  {
                                                    'title': mcqQuestions[
                                                                currentQuestion]
                                                            .option3 ??
                                                        '',
                                                    'backGround': Colors.white,
                                                    'border':
                                                        appColors.brandDark,
                                                    'icon': null,
                                                  },
                                                  {
                                                    'title': mcqQuestions[
                                                                currentQuestion]
                                                            .option4 ??
                                                        '',
                                                    'backGround': Colors.white,
                                                    'border':
                                                        appColors.brandDark,
                                                    'icon': null,
                                                  }
                                                ];
                                              }

                                              int optionIndex = 5;
                                              if (state
                                                  is McqQuestionOptionsState) {
                                                optionIndex = state.index;
                                              }
                                              if (optionIndex < 4 &&
                                                  !questionSubmit) {
                                                options[optionIndex]
                                                        ['backGround'] =
                                                    appColors.brandDark;
                                                options[optionIndex]['border'] =
                                                    appColors.brandDark;
                                              }

                                              return Column(children: [
                                                ...List.generate(4, (index) {
                                                  if (options[index]['title'] ==
                                                      mcqQuestions[
                                                              currentQuestion]
                                                          .correct) {
                                                    correctIndex = index;
                                                  }
                                                  return ListTile(
                                                    onTap: () {
                                                      if (!questionSubmit) {
                                                        BlocProvider.of<
                                                                    McqCubit>(
                                                                context)
                                                            .onChangedOptions(
                                                                index);
                                                      }
                                                    },
                                                    leading: Container(
                                                        height: 26,
                                                        width: 26,
                                                        decoration: BoxDecoration(
                                                            color: options[
                                                                    index]
                                                                ['backGround'],
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: options[
                                                                        index]
                                                                    ['border'],
                                                                width: 2)),
                                                        child: options[index]
                                                            ['icon']),
                                                    title: Text(
                                                      options[index]['title'],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    // trailing: options[index]['backGround'] == Colors.green &&
                                                    //         index != optionIndex
                                                    //     ? GestureDetector(
                                                    //         onTap: () {
                                                    //           showDialog(
                                                    //             barrierDismissible: false,
                                                    //             context: context,
                                                    //             builder: (context) => ReportDialog(
                                                    //               isChapterReport:
                                                    //                   widget.chapterModel != null ? true : false,
                                                    //               reportedModel: mcqQuestions[currentQuestion],
                                                    //             ),
                                                    //           );
                                                    //         },
                                                    //         child: const SizedBox(
                                                    //           width: 80,
                                                    //           child: Row(
                                                    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    //             children: [
                                                    //               Icon(
                                                    //                 Icons.error_outline,
                                                    //                 size: 22,
                                                    //                 color: Colors.red,
                                                    //               ),
                                                    //               Text(
                                                    //                 'Report',
                                                    //                 style: TextStyle(
                                                    //                     color: Colors.red,
                                                    //                     fontSize: 14,
                                                    //                     fontWeight: FontWeight.w600),
                                                    //               )
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //       )
                                                    //     : const SizedBox(),
                                                  );
                                                }),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                questionSubmit && !isAnsValid
                                                    ? Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        ReportDialog(
                                                                  isChapterReport:
                                                                      widget.chapterModel !=
                                                                              null
                                                                          ? true
                                                                          : false,
                                                                  reportedModel:
                                                                      mcqQuestions[
                                                                          currentQuestion],
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.8),
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .error_outline,
                                                                    size: 22,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  Text(
                                                                    'Report',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                                optionIndex != 5
                                                    ? CustomButton(
                                                        title: currentQuestion ==
                                                                    mcqQuestions
                                                                            .length -
                                                                        1 &&
                                                                questionSubmit
                                                            ? 'Submit'
                                                            : questionSubmit
                                                                ? 'Continue'
                                                                : 'Select',
                                                        onTap: () async {
                                                          // Adding to local database

                                                          if (currentQuestion ==
                                                                  0 &&
                                                              !questionSubmit) {
                                                            if (widget
                                                                    .chapterModel !=
                                                                null) {
                                                              box.add({
                                                                "grade_id": widget
                                                                    .chapterModel!
                                                                    .gradeId,
                                                                "chapter_id": widget
                                                                    .chapterModel!
                                                                    .id,
                                                                "sub_id": widget
                                                                    .chapterModel!
                                                                    .subId,
                                                                "chapNo": widget
                                                                    .chapterModel!
                                                                    .chapNo,
                                                                "name": widget
                                                                    .chapterModel!
                                                                    .name,
                                                                "subject":
                                                                    widget
                                                                        .subject
                                                              });
                                                            } else {
                                                              box.add({
                                                                "subject": widget
                                                                    .subject,
                                                                "id": widget
                                                                    .examModel!
                                                                    .id,
                                                                "gradeId": widget
                                                                    .examModel!
                                                                    .gradeId,
                                                                "subId": widget
                                                                    .examModel!
                                                                    .subId,
                                                                "name": widget
                                                                    .examModel!
                                                                    .examName,
                                                                "examYear": widget
                                                                    .examModel!
                                                                    .examYear
                                                              });
                                                            }
                                                          }
                                                          if (!questionSubmit) {
                                                            //adding user ans to send to backend
                                                            userResponses.add({
                                                              "ques_id":
                                                                  mcqQuestions[
                                                                          currentQuestion]
                                                                      .id,
                                                              "response": options[
                                                                      optionIndex]
                                                                  ['title']
                                                            });
                                                            box.add(
                                                                userResponses
                                                                    .last);
                                                            mcqQuestions[
                                                                    currentQuestion]
                                                                .userSelected = options[
                                                                    optionIndex]
                                                                ['title'];
                                                            setState(() {
                                                              isAnsValid = options[
                                                                          optionIndex]
                                                                      [
                                                                      'title'] ==
                                                                  mcqQuestions[
                                                                          currentQuestion]
                                                                      .correct;
                                                              questionSubmit =
                                                                  true;
                                                            });

                                                            if (!isAnsValid) {
                                                              setState(() {
                                                                options[optionIndex]
                                                                        [
                                                                        'icon'] =
                                                                    const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20);
                                                                options[optionIndex]
                                                                        [
                                                                        'backGround'] =
                                                                    Colors.red;
                                                                options[optionIndex]
                                                                        [
                                                                        'border'] =
                                                                    Colors.red;
                                                                options[correctIndex]
                                                                        [
                                                                        'icon'] =
                                                                    const Icon(
                                                                  Icons
                                                                      .check_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20,
                                                                );
                                                                options[correctIndex]
                                                                        [
                                                                        'backGround'] =
                                                                    Colors
                                                                        .green;
                                                                options[correctIndex]
                                                                        [
                                                                        'border'] =
                                                                    Colors
                                                                        .green;
                                                              });
                                                            }
                                                            if (isAnsValid) {
                                                              options[optionIndex]
                                                                      ['icon'] =
                                                                  const Icon(
                                                                      Icons
                                                                          .check_rounded,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20);
                                                              options[optionIndex]
                                                                      [
                                                                      'backGround'] =
                                                                  Colors.green;
                                                              options[optionIndex]
                                                                      [
                                                                      'border'] =
                                                                  Colors.green;
                                                            }
                                                            print(isAnsValid);
                                                          } else {
                                                            setState(() {
                                                              questionSubmit =
                                                                  false;
                                                              isAnsValid = true;
                                                            });
                                                            if (currentQuestion !=
                                                                mcqQuestions
                                                                        .length -
                                                                    1) {
                                                              _horizontalDragEnd();
                                                              if (mcqQuestions
                                                                          .length -
                                                                      (currentQuestion +
                                                                          1) <=
                                                                  2) {
                                                                setState(() {
                                                                  currentIndex =
                                                                      (mcqQuestions.length -
                                                                              1) -
                                                                          (currentQuestion +
                                                                              1);
                                                                });
                                                              }
                                                              BlocProvider.of<
                                                                          McqCubit>(
                                                                      context)
                                                                  .onChangedOptions(
                                                                      5);
                                                              if (currentQuestion <
                                                                  mcqQuestions
                                                                          .length -
                                                                      1) {
                                                                setState(() {
                                                                  currentQuestion =
                                                                      currentQuestion +
                                                                          1;
                                                                });
                                                              }
                                                            } else {
                                                              //after completing all questions
                                                              if (widget
                                                                      .chapterModel !=
                                                                  null) {
                                                                box.clear();
                                                                await BlocProvider.of<
                                                                            McqCubit>(
                                                                        context)
                                                                    .submitStudentAns(
                                                                        userResponses,
                                                                        context,
                                                                        widget
                                                                            .chapterModel!
                                                                            .subId!,
                                                                        widget
                                                                            .chapterModel!
                                                                            .id!);
                                                              } else {
                                                                box.clear();
                                                                await BlocProvider.of<McqCubit>(context).submitQp(
                                                                    answers:
                                                                        userResponses,
                                                                    context:
                                                                        context,
                                                                    subId: widget
                                                                        .examModel!
                                                                        .subId,
                                                                    examId: widget
                                                                        .examModel!
                                                                        .id);
                                                              }
                                                              BlocProvider.of<
                                                                          DashboardCubit>(
                                                                      context)
                                                                  .getData();
                                                            }
                                                          }
                                                        },
                                                      )
                                                    : const SizedBox(),
                                                questionSubmit &&
                                                        mcqQuestions[
                                                                    currentQuestion]
                                                                .description !=
                                                            null
                                                    ? Animate(
                                                        effects: const [
                                                          FadeEffect(),
                                                          SlideEffect(
                                                              begin:
                                                                  Offset(-1, 0))
                                                        ],
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Description',
                                                              style: appFonts
                                                                  .f16w600Black,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      minHeight:
                                                                          100),
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              child: Text(
                                                                '${mcqQuestions[currentQuestion].description}',
                                                                style: appFonts
                                                                    .f14w600Black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ]);
                                            }),
                                        appSpaces.spaceForHeight25,
                                      ],
                                    ),
                                  )
                                : const SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                          'No Questions found in this chapter'),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                })),
      ),
    );
  }

  Offset _getStackedCardOffset(int index) {
    if (currentIndex - 1 == index) {
      return _moveAnim.value;
    } else if (index == currentIndex) {
      if (index == 0) {
        return const Offset(0.0, 0.00);
      }
      return const Offset(0.0, 0.07);
    } else if (index == currentIndex - 2) {
      return const Offset(0.0, -0.15);
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  double _getStackedCardScale(int index) {
    int diff = index - currentIndex;
    if (index == currentIndex) {
      return 1.0;
    } else if (index == currentIndex + 1) {
      return _scaleAnim.value;
    } else {
      return (1 - (0.035 * diff.abs()));
    }
  }

  Offset _getFlickTransformOffset(int index) {
    if (index == currentIndex) {
      return _translationAnim.value;
    }
    return const Offset(0.0, 0.0);
  }

  void _horizontalDragEnd() {
    // Swiped Right to Left
    controller.forward().whenComplete(() {
      setState(() {
        controller.reset();
      });
    });
  }

  _pendingExams(List<Map> storedData, int allQuestionLength) async {
    int quesIndex = (storedData.length - 1);
    if ((allQuestionLength - quesIndex) < 3) {
      currentIndex = (allQuestionLength - quesIndex) - 1;
    }
    isCheckPending = true;
    currentQuestion = quesIndex;

    log(userResponses.toString());
  }
}
