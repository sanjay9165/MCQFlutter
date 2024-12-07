import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_state.dart';
import 'package:mcq/core/models/grade_model.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_textField.dart';
import '../../core/cubits/registration_cubit/registrations_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  // TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // TextEditingController gradeController = TextEditingController();
  // TextEditingController dateBirthController = TextEditingController();
  // TextEditingController genderController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<GradeModel> grades = [];
  String selectedGrade = "";
  String selectedGender = "";
  String selectedDOB = "";
  final List<String> gender = ["male", "female"];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RegistrationsCubit>(context).getGrades();
    BlocProvider.of<ProfileCubit>(context).getStudentDetail();
  }

  @override
  void dispose() {
    nameController.dispose();
    // mailController.dispose();
    phoneController.dispose();
    // gradeController.dispose();
    // dateBirthController.dispose();
    // genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.brandDark,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Edit Profile',
                  style: appFonts.f20w700White,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Text(
                      '',
                      style: appFonts.f16w700White,
                    ))
              ],
            ),
          ),
          appSpaces.spaceForHeight20,
          Expanded(
              child: BlocConsumer<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
                      current is ProfileFetchState,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfileSuccessState) {
                      StudentModel student = state.studentModel;
                      // selectedGrade = 'Grade-${student.gradeId}';
                      // if (selectedDOB == '') {
                      //   selectedDOB = student.dob;
                      // }
                      return Stack(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        )),
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            ...List.generate(2, (index) {
                                              List<String> titles = [
                                                'User Name',
                                                // 'Email',
                                                'Phone Number',
                                                // 'Grade',
                                                // 'Date Of Birth',
                                                // 'Gender'
                                              ];
                                              List<TextEditingController>
                                                  values = [
                                                nameController
                                                  ..text = student.name ?? '',
                                                // mailController
                                                //   ..text = student.email ?? '',
                                                phoneController
                                                  ..text =
                                                      student.phoneNo ?? '',
                                                // gradeController
                                                //   ..text =
                                                //       student.gradeId.toString(),
                                                // dateBirthController
                                                //   ..text = student.dob.toString(),
                                                // genderController
                                                //   ..text = student.gender ?? ''
                                              ];

                                              return CustomTextField(
                                                isReadOnly: index == 1,
                                                controller: values[index],
                                                label: titles[index],
                                                validator: (p0) {
                                                  if (index == 0) {
                                                    if (p0 == '' ||
                                                        p0 == null) {
                                                      return 'Please enter a name';
                                                    }
                                                  } else if (index == 1) {
                                                    if (p0 == '') {
                                                      return 'Please enter a phone number';
                                                    }
                                                  } else if (index == 2) {
                                                    if (p0 == '') {
                                                      return 'Please enter a phone number';
                                                    } else if (p0!.length <
                                                            10 ||
                                                        p0.length > 10) {
                                                      return 'Please enter a valid phone number';
                                                    }
                                                  }
                                                  return null;
                                                },
                                              );
                                            }),
                                            // BlocBuilder<RegistrationsCubit,
                                            //         RegistrationsState>(
                                            //     builder: (context, state) {
                                            //   if (state
                                            //       is RegistrationsGradesLoaded) {
                                            //     grades = state.grades;
                                            //     int currentGrade = int.parse(
                                            //         student.gradeId.toString());
                                            //     return DropdownButtonFormField(
                                            //         value:
                                            //             grades[currentGrade - 1]
                                            //                 .id
                                            //                 .toString(),
                                            //         validator: (value) {
                                            //           if (value
                                            //                   .toString()
                                            //                   .trim()
                                            //                   .isEmpty ||
                                            //               value == null) {
                                            //             return "Please Select Gender";
                                            //           }
                                            //           return null;
                                            //         },
                                            //         hint: Text(
                                            //           "Select Grade*",
                                            //           style: appFonts.f14w400Grey,
                                            //         ),
                                            //         decoration:
                                            //             const InputDecoration(),
                                            //         icon: const Icon(Icons
                                            //             .keyboard_arrow_down),
                                            //         items: List.generate(
                                            //             grades.length,
                                            //             (index) => DropdownMenuItem(
                                            //                 value: grades[index]
                                            //                     .id
                                            //                     .toString(),
                                            //                 child: Text(grades[
                                            //                         index]
                                            //                     .name
                                            //                     .toString()))),
                                            //         onChanged: (id) {
                                            //           selectedGrade =
                                            //               id.toString();
                                            //         });
                                            //   } else {
                                            //     return const SizedBox(
                                            //       height: 30,
                                            //     );
                                            //   }
                                            // }),
                                            // appSpaces.spaceForHeight20,
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     showDialog(
                                            //       context: context,
                                            //       builder: (context) => Dialog(
                                            //         child: Column(
                                            //           mainAxisSize:
                                            //               MainAxisSize.min,
                                            //           children: [
                                            //             Material(
                                            //               color: Colors.white,
                                            //               shadowColor:
                                            //                   Colors.grey,
                                            //               elevation: 5,
                                            //               borderRadius:
                                            //                   BorderRadius
                                            //                       .circular(8),
                                            //               child:
                                            //                   CalendarDatePicker(
                                            //                       initialDate:
                                            //                           DateTime(
                                            //                               DateTime.now().year -
                                            //                                   18,
                                            //                               12,
                                            //                               12),
                                            //                       firstDate: DateTime(
                                            //                           DateTime.now()
                                            //                                   .year -
                                            //                               90),
                                            //                       lastDate:
                                            //                           DateTime
                                            //                               .now(),
                                            //                       onDateChanged:
                                            //                           (selected) {
                                            //                         setState(
                                            //                             () {
                                            //                           // selectedDOB = selected
                                            //                           //     .toString()
                                            //                           //     .split(
                                            //                           //         " ")[0];
                                            //                         });
                                            //                       }),
                                            //             ),
                                            //             appSpaces
                                            //                 .spaceForHeight20,
                                            //             Padding(
                                            //               padding:
                                            //                   const EdgeInsets
                                            //                       .symmetric(
                                            //                       horizontal:
                                            //                           12),
                                            //               child: CustomButton(
                                            //                 title: 'Done',
                                            //                 onTap: () {
                                            //                   Get.back();
                                            //                 },
                                            //               ),
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     );
                                            //   },
                                            //   child: Container(
                                            //     height: 45,
                                            //     width: double.infinity,
                                            //     decoration: const BoxDecoration(
                                            //         border: Border(
                                            //             bottom: BorderSide(
                                            //                 color:
                                            //                     Colors.black))),
                                            //     child: Text(
                                            //       selectedDOB == ''
                                            //           ? student.dob ??
                                            //               'Date Of Birth'
                                            //           : selectedDOB,
                                            //       style: appFonts.f16w600Black,
                                            //     ),
                                            //   ),
                                            // ),
                                            // appSpaces.spaceForHeight10,
                                            // DropdownButtonFormField(
                                            //     value: student.gender,
                                            //     validator: (value) {
                                            //       if (value
                                            //               .toString()
                                            //               .trim()
                                            //               .isEmpty ||
                                            //           value == null) {
                                            //         return "Please Select Gender";
                                            //       }
                                            //       return null;
                                            //     },
                                            //     hint: Text(
                                            //       "Select Gender",
                                            //       style: appFonts.f14w400Grey,
                                            //     ),
                                            //     decoration:
                                            //         const InputDecoration(),
                                            //     icon: const Icon(
                                            //         Icons.keyboard_arrow_down),
                                            //     items: List.generate(
                                            //         gender.length,
                                            //         (index) => DropdownMenuItem(
                                            //             value: gender[index],
                                            //             child:
                                            //                 Text(gender[index]))),
                                            //     onChanged: (val) {
                                            //       selectedGender = val.toString();
                                            //     }),
                                            appSpaces.spaceForHeight20,
                                            CustomButton(
                                              title: 'Done',
                                              onTap: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  Map<String, dynamic>
                                                      updateData = {
                                                    "phone_no": student.phoneNo,

                                                    "name": nameController.text
                                                        .trim(),
                                                    // "grade_id": selectedGrade
                                                    //     .split('-')
                                                    //     .last,
                                                    // "gender": selectedGender == ''
                                                    //     ? student.gender
                                                    //     : selectedGender,
                                                    // "dob": selectedDOB
                                                  };
                                                  BlocProvider.of<ProfileCubit>(
                                                          context)
                                                      .updateStudentDetail(
                                                          id: student.id,
                                                          updateData:
                                                              updateData);
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: AssetImage(
                                            student.gender == 'male'
                                                ? appImages.defaultAvatar
                                                : appImages.femaleAvatar),
                                        fit: BoxFit.fill)),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: ColoredBox(
                          color: Colors.white,
                          child: SizedBox(
                            height: screenHeight(context),
                            width: screenWidth(context),
                            child: const Center(
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()),
                            ),
                          ),
                        ),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
