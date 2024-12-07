// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/route_manager.dart';
// import 'package:mcq/core/cubits/exam_lsit_cubit/exam_lsit_cubit.dart';
// import 'package:mcq/core/models/exam_model.dart';
// import 'package:mcq/core/models/subject_model.dart';
// import 'package:mcq/utils/screen_dimensions.dart';
// import '../../manager/color_manager.dart';
// import '../../manager/font_manager.dart';
// import '../../manager/image_manager.dart';
// import '../../widgets/custom_network_image.dart';
//
// class ExamListScreen extends StatefulWidget {
//   final SubjectModel subjectModel;
//
//   const ExamListScreen({super.key, required this.subjectModel});
//
//   @override
//   State<ExamListScreen> createState() => _ExamListScreenState();
// }
//
// class _ExamListScreenState extends State<ExamListScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     //
//     BlocProvider.of<ExamListCubit>(context)
//         .getExamList(subId: widget.subjectModel.id.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final String grade = widget.subjectModel.gradeId.toString();
//     final String subject = widget.subjectModel.name.toString();
//     final String imageUrl = widget.subjectModel.image.toString();
//
//     return Scaffold(body: BlocBuilder<ExamListCubit, ExamListState>(
//       builder: (context, state) {
//         if (state is ExamListLoaded) {
//           final List<ExamModel> examModel = state.exams;
//           return ListView(
//             children: [
//               Container(
//                 height: 100,
//                 padding: const EdgeInsets.symmetric(horizontal: 0),
//                 decoration: BoxDecoration(
//                   color: appColors.brandLite,
//                   borderRadius:
//                       const BorderRadius.only(bottomLeft: Radius.circular(45)),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const BackButton(),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: 190,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           RichText(
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                               text: TextSpan(
//                                   text: "Grade $grade  ",
//                                   style: appFonts.f16w600Black,
//                                   children: [
//                                     TextSpan(
//                                         text: subject,
//                                         style: appFonts.f20w600Black)
//                                   ])),
//
//                           ///
//                           Text(
//                             "Questions ${examModel.length}",
//                             style: appFonts.f14w600Grey,
//                           )
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     CustomNetworkImage(
//                       url: imageUrl,
//                       height: 60,
//                       width: 100,
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: getDimension(context: context, verticalPadding: 100).h,
//                 child: ListView.builder(
//                     itemCount: examModel.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15.0, vertical: 20),
//                         child: Material(
//                           elevation: 5,
//                           surfaceTintColor: Colors.white,
//                           shadowColor: Colors.grey,
//                           borderRadius: BorderRadius.circular(5),
//                           child: ListTile(
//                             onTap: () {
//                               int? id;
//                               int? gradeId;
//                               int? subId;
//                               Get.toNamed("/PendingAndCompleted",arguments: {
//                                 "subject":'',
//                                 "examModel":examModel[index]
//                               });
//                               // Get.toNamed("/QuestionsMCQListScreen",
//                               //     arguments: examModel[index]);
//                             },
//                             leading: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset(appImages.exam),
//                             ),
//                             title: Text(
//                               "Year: ${examModel[index].examYear}",
//                               style: appFonts.f12w400Grey,
//                             ),
//                             subtitle: Text(
//                               "Year: ${examModel[index].examName}",
//                               style: appFonts.f12w600Black,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               )
//             ],
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     ));
//   }
// }
