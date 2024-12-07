import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:mcq/core/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:mcq/core/models/QP_pending_exam_model.dart';
import 'package:mcq/core/models/subject_model.dart';
import 'package:mcq/main.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../../core/cubits/notification_cubit/notificatioin_state.dart';
import '../../../core/cubits/notification_cubit/notification_cubit.dart';
import '../../../core/cubits/search_cubit/search_cubit.dart';
import '../../../core/models/chapter_model.dart';
import '../../../widgets/home_screen/ongoing_tests_list.dart';
import '../../../widgets/home_screen/progress_card.dart';
import '../../../widgets/home_screen/subject_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DashboardCubit>(context).getData();
    BlocProvider.of<NotificationCubit>(context).getAllNotifications();
    _checkingPendingExams();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.brandDark,
        actions: [
          BlocBuilder<NotificationCubit, NotificationState>(
              buildWhen: (previous, current) =>
                  current is NotificationFetchState,
              builder: (context, state) {
                bool isNewNotification = false;
                if (state is NotificationFetchSuccessState &&
                    state.allNotifications.isNotEmpty) {
                  isNewNotification = true;
                }
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/Notification');
                  },
                  child: Badge(
                    isLabelVisible: isNewNotification,
                    child: const Icon(
                      CupertinoIcons.bell,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
          appSpaces.spaceForWidth20,
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            String name = state.data.studentName.toString();
            String gender = state.data.studentGender.toString();
            double avgScore = state.data.averageScore != null
                ? double.parse(state.data.averageScore.toString())
                    .truncateToDouble()
                : 0;
            List<ChaptersModel> chapters = [];
            final bool progress = state.data.progress.toString().contains('1');
            if (state.data.allChapters != null) {
              chapters = state.data.allChapters as List<ChaptersModel>;
            }
            // List<SubjectModel> subjects = [];
            // if (state.data.subjectsData != null) {
            //   subjects = state.data.subjectsData as List<SubjectModel>;
            // }

            return ListView(
              children: [
                Material(
                  color: appColors.brandDark,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: SizedBox(
                    height: 180,
                    child: Column(
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello,",
                                style: appFonts.f16w600White,
                              ),
                              Text(
                                name,
                                style: appFonts.f20w700White,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "Let’s workout to get some gains",
                            style: appFonts.f14w400White,
                          ),
                          trailing: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(gender != "female"
                                ? appImages.mDP
                                : appImages.fDP),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: SearchBar(
                            hintText: "Search For Text",
                            controller: searchController,
                            leading: const Icon(CupertinoIcons.search),
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            surfaceTintColor:
                                const WidgetStatePropertyAll(Colors.white),
                            trailing: [
                              BlocBuilder<SearchCubit, SearchState>(
                                builder: (context, searchState) {
                                  if (searchState is! SearchInitial) {
                                    return IconButton(
                                        onPressed: () {
                                          BlocProvider.of<SearchCubit>(context)
                                              .resetSearch();
                                          searchController.clear();
                                        },
                                        icon: const Icon(Icons.close));
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              )
                            ],
                            onSubmitted: (value) {
                              BlocProvider.of<SearchCubit>(context)
                                  .searchTest(value: value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, searchState) {
                    if (searchState is SearchLoaded) {
                      return SizedBox(
                        height:
                            searchState.searchedChapters.isNotEmpty ? 500 : 0,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              mainAxisExtent: 190,
                            ),
                            itemCount: searchState.searchedChapters.length,
                            itemBuilder: (context, index) {
                              return TestCard(
                                model: searchState.searchedChapters[index],
                                imageUrl: appImages.onBoardingImage,
                                title: searchState.searchedChapters[index].name
                                    .toString(),
                                chapter:
                                    "Chapter ${searchState.searchedChapters[index].chapNo.toString()}",
                                borderColor: Colors.blue,
                              );
                            }),
                      );
                    } else if (searchState is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 5,
                  shadowColor: Colors.grey,
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Average Score",
                                style: appFonts.f14w600Black,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  avgScore.toString(),
                                  style: appFonts.f16w600,
                                ),
                              ),
                              // Text("in 6 Subjects",style: appFonts.f12w600Grey,),
                            ],
                          ),
                          SimpleCircularProgressBar(
                            size: 70,
                            valueNotifier: ValueNotifier(avgScore),
                            backColor: Colors.grey.withOpacity(0.2),
                            backStrokeWidth: 20,
                            progressStrokeWidth: 15,
                            mergeMode: true,
                            progressColors: [
                              appColors.brandDark.withOpacity(0.5),
                              appColors.brandDark,
                            ],
                            onGetText: (double value) {
                              TextStyle centerTextStyle = TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: appColors.brandDark,
                              );

                              return Text(
                                '${value.toInt()}%',
                                style: centerTextStyle,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ProgressCard(
                  isProgress: progress,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Ongoing Tests",
                //         style: appFonts.f14w600Black,
                //       ),
                //       TextButton(
                //           onPressed: () {
                //             if(chapters.isNotEmpty) {
                //               Get.toNamed("/OngoingTestListScreen", arguments: chapters);
                //             }else{
                //               customSnackBar(title: 'No Tests', message: 'No Tests to show');
                //             }
                //           },
                //           child: Text(
                //             "View all >",
                //             style: appFonts.f14w600Grey,
                //           )),
                //     ],
                //   ),
                // ),
                // OngoingTestsList(
                //   models: chapters,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Subjects",
                //         style: appFonts.f14w600Black,
                //       ),
                //       TextButton(
                //           onPressed: () {
                //             if (subjects.isNotEmpty) {
                //               Get.toNamed("/SubjectListScreen",
                //                   arguments: subjects);
                //             } else {
                //               customSnackBar(
                //                   title: 'No Subjects',
                //                   message: 'No subjects to show');
                //             }
                //           },
                //           child: Text(
                //             "View all >",
                //             style: appFonts.f14w600Grey,
                //           )),
                //     ],
                //   ),
                // ),
                // subjects.isNotEmpty
                //     ? SubjectsList(
                //         subjects: subjects,
                //       )
                //     : SizedBox(
                //         height: 40,
                //         width: double.infinity,
                //         child: Center(
                //           child: Text(
                //             'No Subjects to show',
                //             style: appFonts.f14w600BrandDark,
                //           ),
                //         ),
                //       ),
                const SizedBox(
                  height: 40,
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _checkingPendingExams() async {
    try {
      Box box = await Hive.openBox<Map>(boxName);
      final modelData = box.values.first;

      if (modelData['chapter_id'] != null) {
        Get.toNamed("/McqListScreen", arguments: {
          "subject": modelData['subject'],
          "chapterModel": ChaptersModel(
              subId: modelData['sub_id'],
              id: int.parse(modelData['chapter_id'].toString()),
              chapNo: 1,
              gradeId: modelData['grade_id'],
              name: ''),
        });
      } else {
        Get.toNamed("/McqListScreen", arguments: {
          "subject": modelData['subject'],
          "examModel": QpExamsModel(
            id: modelData['id'],
            gradeId: modelData['grade_id'],
            subId: modelData['subId'],
            examName: modelData['examName'],
            examYear: modelData['examYear'],
          )
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('============error on hive $e');
      }
    }
  }
}
