import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:mcq/core/cubits/QP_subjects_cubit/qp_subjects_cubit.dart';

import '../../core/models/QP_subjects_model.dart';
import '../../manager/font_manager.dart';
import '../../utils/getColor.dart';
import '../../widgets/home_screen/subject_list.dart';

class QPSubjectListScreen extends StatefulWidget {
  const QPSubjectListScreen({super.key});

  @override
  State<QPSubjectListScreen> createState() => _QPSubjectListScreenState();
}

class _QPSubjectListScreenState extends State<QPSubjectListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<QpSubjectsCubit>(context).getQPSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QpSubjectsCubit, QpSubjectsState>(
      builder: (context, state) {
        List<QPSubjects> subjects = [];

        if (state is QpSubjectsLoaded) {
          subjects.addAll(state.subjects.subjects ?? []);
        } else {
          subjects = [];
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Question Papers",
              style: appFonts.f16w600Black,
            ),
            centerTitle: true,
          ),
          body: state is QpSubjectsLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 180,
                      ),
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        var subjects0 = subjects[index].subject;
                        return DashboardSubjectCard(
                            borderColor: getColor(color: subjects0!.color.toString()),
                            imageUrl: subjects0.image.toString(),
                            testsDone: "${subjects[index].totalAttempts.toString()}/"
                                "${subjects[index].totalExams.toString()} Tests Done",
                            title: subjects0.name.toString(),
                            score: double.parse(subjects[index].averageScore.toString()),
                            onTap: () {
                                  Get.toNamed('/QPPendingAndCompletedScreen',
                                      arguments:  subjects[index]
                                  );
                            });
                        // SubjectCard(
                        //   title: _subjects!.name.toString(),
                        //   imageUrl: _subjects.image.toString(),
                        //   borderColor: getColor(color: _subjects.color.toString()),
                        //   onTap: () {
                        //
                        //     Get.toNamed('/QPPendingAndCompletedScreen',
                        //         arguments:  subjects[index]
                        //     );
                        //   },
                        // );
                      }),
                ),
        );
      },
    );
  }
}
