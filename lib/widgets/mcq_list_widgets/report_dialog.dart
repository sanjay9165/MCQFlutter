import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcq/core/cubits/mcq_cubit/mcq_cubit.dart';
import 'package:mcq/core/models/mcq_model.dart';
import 'package:mcq/utils/image_picking.dart';

import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';
import '../../manager/space_manager.dart';
import '../../utils/screen_dimensions.dart';
import '../custom_button.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({
    super.key,
    required this.reportedModel,
    required this.isChapterReport,
  });
  final McqModel reportedModel;
  final bool isChapterReport;
  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final ImagePicker picker = ImagePicker();
  final TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? imageFile;
  String reportedItem='Question';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(

                        children: [
                          Text('Which is you want to report',style: appFonts.f14w600Black,),
                          Row(
                            children: List.generate(2, (index) {
                              List<String> titles = ['Question', 'Option'];
                              return Expanded(
                                child: RadioListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: Text(titles[index]),
                                  value: titles[index],
                                  groupValue: reportedItem,
                                  onChanged: (value) {
                                    setState(() {
                                      reportedItem=titles[index];
                                    });
                                  },
                                ),
                              );
                            }),
                          )
                        ],

                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 10,
                        child: Center(
                          child: Icon(
                            Icons.close,
                            size: 17,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              appSpaces.spaceForHeight20,
              Form(
                key: formKey,
                child: Container(
                  height: 166,
                  width: screenWidth(context) - 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1.5)]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: textEditingController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintStyle: appFonts.f14w400Grey,
                        hintText: 'Enter the explanation for why you believe the provided answer is incorrect',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Please provide the explanation';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              appSpaces.spaceForHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  appSpaces.spaceForWidth10,
                  GestureDetector(
                    onTap: () {
                      // _selectImageSourceDialog();
                      if (imageFile == null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Select Source"),
                            content: Row(
                              children: [
                                CustomButton(
                                    width: 75,
                                    title: "Camera",
                                    onTap: () async {
                                      Get.back();
                                      final image = await imagePicking(ImageSource.camera);
                                      if (image != null) {
                                        setState(() {
                                          imageFile = image;
                                        });
                                      }
                                    }),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomButton(
                                    width: 75,
                                    title: "Gallery",
                                    onTap: () async {
                                      Get.back();
                                      final image = await imagePicking(ImageSource.gallery);
                                      if (image != null) {
                                        setState(() {
                                          imageFile = image;
                                        });
                                      }
                                    }),
                              ],
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          imageFile = null;
                        });
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 145,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: appColors.brandDark, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            imageFile == null ? Icons.attach_file_outlined : Icons.close,
                            color: appColors.brandDark,
                          ),
                          Text(imageFile == null ? 'Attach Files' : 'File Uploaded', style: appFonts.f14w600BrandDark)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              appSpaces.spaceForHeight20,
              CustomButton(
                  title: 'Submit',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> details = {
                        'ques_id': widget.reportedModel.id.toString(),
                        'marked_answer': widget.reportedModel.userSelected,
                        'correct_answer': widget.reportedModel.correct,
                        'file': imageFile,
                        'description': textEditingController.text,
                        'isQuestion':reportedItem=='Question'?1:0
                      };
                      if (widget.isChapterReport) {
                        BlocProvider.of<McqCubit>(context).reportMcqQuestion(details, context);
                      } else {
                        BlocProvider.of<McqCubit>(context).reportQp(details, context);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  _selectImageSourceDialog() {
    return AlertDialog(
      title: const Text("Select Source"),
      content: Row(
        children: [
          CustomButton(
              width: 75,
              title: "Camera",
              onTap: () async {
                // setState(() {
                //   dialogLoading = true;
                // });
                Get.back();
                await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 10).then(
                  (value) async {
                    // setState(() {
                    //   image = value;
                    //   dialogLoading = false;
                    // });
                    //
                    // customSnackBar(
                    //     title: "Successful",
                    //     message: "Image Uploaded Successfully");
                  },
                );
              }),
          const SizedBox(
            width: 10,
          ),
          CustomButton(
              width: 75,
              title: "Gallery",
              onTap: () async {
                // setState(() {
                //   dialogLoading = true;
                // });
                Get.back();
                await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10).then((value) {
                  // setState(() {
                  //   image = value;
                  //   dialogLoading = false;
                  // });
                  // customSnackBar(
                  //     title: "Successful",
                  //     message: "Image Uploaded Successfully");
                });
              }),
        ],
      ),
    );
  }
}
