// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:mcq/core/cubits/QP_mcq_cubit/qp_mcq_cubit.dart';
// import 'package:mcq/core/models/exam_model.dart';
// import 'package:mcq/utils/screen_dimensions.dart';
//
// import '../../manager/color_manager.dart';
// import '../../manager/font_manager.dart';
// import '../../widgets/questions_mcq_list_widgets/mcq_non_editable_card.dart';
//
// class QuestionsMCQListScreen extends StatefulWidget {
//   final ExamModel examModel;
//
//   const QuestionsMCQListScreen({super.key, required this.examModel});
//
//   @override
//   State<QuestionsMCQListScreen> createState() => _QuestionsMCQListScreenState();
// }
//
// class _QuestionsMCQListScreenState extends State<QuestionsMCQListScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<QpMcqCubit>(context)
//         .getQPMcq(examId: widget.examModel.id.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           title: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 widget.examModel.examName.toString(),
//                 style: appFonts.f16w600Black,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 widget.examModel.examYear.toString(),
//                 style: appFonts.f12w400Grey,
//               ),
//             ],
//           )),
//       body: SafeArea(
//         child: BlocBuilder<QpMcqCubit, QpMcqState>(
//           builder: (context, state) {
//             if (state is QpMcqLoaded) {
//               return ListView.builder(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   itemCount: state.qpMcq.length,
//                   itemBuilder: (context, index) {
//                     List<String> options = [];
//                     options.add(state.qpMcq[index].option1.toString());
//                     options.add(state.qpMcq[index].option2.toString());
//                     options.add(state.qpMcq[index].option3.toString());
//                     options.add(state.qpMcq[index].option4.toString());
//                     int correctAnswer = options.indexOf(
//                         state.qpMcq[index].correct.toString(), 0);
//                     String question = state.qpMcq[index].question.toString();
//                     String description =
//                         state.qpMcq[index].description.toString();
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 15),
//                       child: MCQNonEditableCard(
//                         options: options,
//                         correctAnsIndex: correctAnswer,
//                         question: question,
//                         description: description,
//                       ),
//                     );
//                   });
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
