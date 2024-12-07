import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/widgets/custom_appBar.dart';
import 'package:mcq/widgets/custom_button.dart';

import '../../core/models/review_model.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';
import '../../utils/screen_dimensions.dart';
import '../../widgets/mcq_list_widgets/report_dialog.dart';

class ReviewShowScreen extends StatefulWidget {
  const ReviewShowScreen(
      {super.key,
      required this.reviewResults,
      required this.percentage,
      this.currentQuestion,
      required this.isChapter});
  final List<ReviewModel> reviewResults;
  final String percentage;
  final int? currentQuestion;
  final bool isChapter;
  @override
  State<ReviewShowScreen> createState() => _ReviewShowScreenState();
}

class _ReviewShowScreenState extends State<ReviewShowScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 2;
  int currentQuestion = 1;
  int remaining = 0;
  String correctAns = '';
  String submitAns = '';
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late Animation<Offset> _translationAnim;
  late Animation<Offset> _moveAnim;
  late Animation<double> _scaleAnim;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    print(widget.currentQuestion);
    currentQuestion = widget.currentQuestion ?? 1;
    remaining = widget.reviewResults.length - (currentQuestion - 1);
    if ((remaining - 1) < currentIndex) {
      currentIndex = remaining - 1;
    }
    correctAns = widget.reviewResults[currentQuestion - 1].question!.correct!.trim();
    submitAns = widget.reviewResults[currentQuestion - 1].response??''.trim();
    CurvedAnimation curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    Animation<Offset> animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-5.0, 0.0),
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    _translationAnim = Tween(begin: const Offset(0.0, -5.0), end: const Offset(-1000.0, 0.0)).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    _scaleAnim = Tween(begin: 0.965, end: 1.0).animate(curvedAnimation);
    _moveAnim = Tween(begin: const Offset(0.0, -0.05), end: const Offset(0.0, 0.0)).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              appSpaces.spaceForHeight10,
              const CustomAppBar(title: 'Answers'),
              appSpaces.spaceForHeight10,
              Text(
                "You're Right",
                style: appFonts.f16w600Black,
              ),
              appSpaces.spaceForWidth10,
              Text(
                "${double.parse(widget.percentage).toInt().toString()}%",
                style: appFonts.f16w600,
              ),
              appSpaces.spaceForHeight20,
              widget.reviewResults[currentQuestion - 1].question!.description != null
                  ? Animate(
                      effects: const [FadeEffect(), SlideEffect(begin: Offset(-1, 0))],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: appFonts.f16w600Black,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(minHeight: 100),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              '${widget.reviewResults[currentQuestion - 1].question!.description}',
                              style: appFonts.f14w600Black,
                            ),
                          ),
                          appSpaces.spaceForHeight10,
                        ],
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                width: double.infinity,
                child: Stack(
                    children: List.generate(remaining > 2 ? 3 : remaining, (index) {
                  print(currentIndex);
                  // print(widget.reviewResults[])
                  List<Color> colors = [
                    appColors.brandDark,
                    appColors.brandDark.withOpacity(0.7),
                    appColors.brandDark.withOpacity(0.5)
                  ];
                  return Transform.translate(
                    offset: _getFlickTransformOffset(index),
                    child: FractionalTranslation(
                      translation: _getStackedCardOffset(index),
                      child: Transform.scale(
                        scale: _getStackedCardScale(index),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                            constraints: const BoxConstraints(
                              minHeight: 180,
                            ),
                            width: screenWidth(context) - 40,
                            // width:index==0?screenWidth(context)-115:index==1?screenWidth(context)-80:screenWidth(context)-30,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: colors[currentIndex - index], borderRadius: BorderRadius.circular(10)),
                            child: index == currentIndex
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Question $currentQuestion',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      appSpaces.spaceForHeight20,
                                      Text(
                                        widget.reviewResults[currentQuestion - 1].question!.question ?? '',
                                        style: appFonts.f16w600White,
                                      )
                                    ],
                                  )
                                : const SizedBox()),
                      ),
                    ),
                  );
                })),
              ),
              appSpaces.spaceForHeight25,
              ...List.generate(4, (index) {
                List<Map<String, dynamic>> options = List.generate(4, (index) {
                  List<String> option = [
                    widget.reviewResults[currentQuestion - 1].question!.option1!.trim(),
                    widget.reviewResults[currentQuestion - 1].question!.option2 !.trim(),
                    widget.reviewResults[currentQuestion - 1].question!.option3 !.trim(),
                    widget.reviewResults[currentQuestion - 1].question!.option4 !.trim()
                  ];
                  return {
                    'title': option[index],
                    'backGround': option[index] == correctAns
                        ? Colors.green
                        : option[index] == submitAns
                            ? Colors.red
                            : Colors.white,
                    'border': option[index] == correctAns
                        ? Colors.green
                        : option[index] == submitAns
                            ? Colors.red
                            : appColors.brandDark,
                    'icon': option[index] == correctAns
                        ? const Icon(Icons.check_rounded, size: 20, color: Colors.white)
                        : option[index] == submitAns
                            ? const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              )
                            : null,
                  };
                });

                return ListTile(
                  onTap: () {},
                  leading: Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: options[index]['backGround'],
                          shape: BoxShape.circle,
                          border: Border.all(color: options[index]['border'], width: 2)),
                      child: options[index]['icon']),
                  title: Text(
                    options[index]['title'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  trailing: options[index]['backGround'] == Colors.green && submitAns != correctAns
                      ? GestureDetector(
                          onTap: () {
                            widget.reviewResults[currentQuestion].question!.userSelected =
                                widget.reviewResults[currentQuestion].response;
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => ReportDialog(
                                reportedModel: widget.reviewResults[currentQuestion].question!,
                                isChapterReport: widget.isChapter,
                              ),
                            );
                          },
                          child: const SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 22,
                                  color: Colors.red,
                                ),
                                Text(
                                  'Report',
                                  style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                );
              }),
              appSpaces.spaceForHeight25,
              CustomButton(
                title: remaining != 1 ? 'Continue' : 'Done',
                onTap: () {
                  if (remaining == 1) {
                    Get.back();
                  } else {
                    setState(() {
                      remaining--;
                      currentQuestion++;
                      correctAns = widget.reviewResults[currentQuestion - 1].question!.correct!.trim();
                      submitAns = widget.reviewResults[currentQuestion - 1].response!.trim();
                    });
                    if ((remaining - 1) < currentIndex) {
                      setState(() {
                        currentIndex = remaining - 1;
                      });
                    }
                    _horizontalDragEnd();
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
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
}
