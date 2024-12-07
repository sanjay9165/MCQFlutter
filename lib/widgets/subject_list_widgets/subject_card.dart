// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
//
// import '../../manager/font_manager.dart';
// import '../../manager/image_manager.dart';
// import '../custom_network_image.dart';
//
// class SubjectCard extends StatelessWidget {
//   final Color borderColor;
//   final String imageUrl;
//   final String title;
//   final Function() onTap;
//   const SubjectCard({super.key, required this.borderColor,
//     required this.imageUrl, required this.title, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         onTap();
//       },
//       splashColor: borderColor,
//      borderRadius: BorderRadius.circular(5),
//       child: Container(
//         height: 120,
//         width: 95,
//         margin: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(
//             color: borderColor,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: borderColor.withOpacity(0.8),
//               blurRadius: 8,
//             )
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomNetworkImage(
//                 url: imageUrl,
//                 height: 80,
//                 width: 150,
//                 fit: BoxFit.fill,
//               ),
//              // Image.asset(appImages.onBoardingImage,height: 48,),
//               const SizedBox(
//                 height: 5,
//               ),
//               SizedBox(
//                 width: 80,
//                 child: Text(title,style: appFonts.f14w600Black,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AddSubjectCard extends StatelessWidget {
//   final bool isQuesPaper;
//   const AddSubjectCard({super.key, required this.isQuesPaper});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: MaterialButton(
//         onPressed: (){
//           if(isQuesPaper){
//             Get.toNamed("/addSubjectForQuePaper");
//           }else{
//             Get.toNamed("/addMCQSubject");
//           }
//         },
//         height: 120,
//         minWidth: 95,
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(4),
//             side: BorderSide(
//               color: Colors.grey.withOpacity(0.4),
//             )
//         ),
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.add,size: 50,color: Colors.grey,),
//             const SizedBox(
//               height: 5,
//             ),
//             Text("Add Subject",style: appFonts.f12w400Grey,
//               textAlign: TextAlign.center,)
//           ],
//         ),
//       ),
//     );
//   }
// }
//
