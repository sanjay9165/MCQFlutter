import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mcq/core/cubits/registration_cubit/registrations_cubit.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/presentation/otp_screen/otp_screen.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mobile_number/mobile_number.dart';
import '../../core/models/grade_model.dart';
import '../../widgets/custom_textField.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final List<String> gender = ["Male", "Female"];
  late List<GradeModel> grades = [];
  final key = GlobalKey<FormState>();
  final StudentModel studentModel = StudentModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneCountroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedGender = "";
  String selectedDOB = DateTime.now().toString().split(" ")[0];
  String selectedGrade = "1";
  bool isAcceptedTerms = false;
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<RegistrationsCubit>(context).getGrades();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneCountroller.dispose();

    super.dispose();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String mobileNumber = (await MobileNumber.mobileNumber)!;
      final simDetails = await MobileNumber.getSimCards!;
      List<SimCard> number = simDetails;
      log(mobileNumber);
      log(number.toString());
      if (number.isNotEmpty) {
        showNumberSelector(number);
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  void showNumberSelector(List<SimCard> number) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select a Mobile Number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              if (number.isEmpty)
                const Center(
                  child: Text(
                    "No SIM cards found or permission denied.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                ...number.toSet().map((sim) {
                  return ListTile(
                    title: Text(sim.number ?? "Unknown Number"),
                    subtitle: Text(sim.carrierName ?? "Unknown Carrier"),
                    onTap: () {
                      phoneCountroller.text =
                          sim.number?.substring(2).trim() ?? "";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Image.asset(
                appImages.logo,
                height: 110,
              ),
            )),
            Text(
              "Create Account",
              style: appFonts.f20w600Black,
            ),
            Text(
              "Create an account to continue",
              style: appFonts.f14w400Grey,
            ),
            CustomTextField(
              label: "Name*",
              controller: nameController,
              validator: (value) {
                if (value.toString().trim().isEmpty || value == null) {
                  return "Please enter name";
                }
                return null;
              },
            ),
            CustomTextField(
              label: "Phone",
              isNumberOnly: true,
              controller: phoneCountroller,
              onTap: () async {
                await initMobileNumberState();
              },
              validator: (value) {
                if (value.toString().trim().isEmpty || value == null) {
                  return "Please enter a valid Phone Number";
                }
                return null;
              },
            ),
            CustomTextField(
              label: "Password",
              controller: passwordController,
              validator: (value) {
                if (value.toString().trim().isEmpty || value == null) {
                  return "Please enter a valid password";
                }
                return null;
              },
            ),
            // CustomTextField(
            //   label: "Email*",
            //   controller: emailController,
            //   validator: (value) {
            //     if (value.toString().trim().isEmpty || value == null) {
            //       return "Please enter mail here";
            //     }
            //     if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
            //       return "Please enter a valid email";
            //     }
            //     return null;
            //   },
            // ),
            // CustomTextField(
            //   label: "Password*",
            //   isPassWord: true,
            //   controller: passwordController,
            //   validator: (value) {
            //     if (value.toString().trim().isEmpty || value == null) {
            //       return "Please enter password here";
            //     } else if (value.length < 6) {
            //       return "Password must have 6 digit";
            //     }
            //     return null;
            //   },
            // ),
            // CustomTextField(
            //   label: "Verify Password*",
            //   isPassWord: true,
            //   validator: (value) {
            //     if (value.toString().trim().isEmpty || value == null) {
            //       return "Please enter here";
            //     } else if (passwordController.text.trim() != value.trim()) {
            //       return "This password doesn't match with above one";
            //     }
            //     return null;
            //   },
            // ),
            const SizedBox(
              height: 25,
            ),
            // BlocBuilder<RegistrationsCubit, RegistrationsState>(
            //   builder: (context, state) {
            //     if (state is RegistrationsGradesLoaded) {
            //       grades = state.grades;
            //       return DropdownButtonFormField(
            //           validator: (value) {
            //             if (value.toString().trim().isEmpty || value == null) {
            //               return "Please Select Grade";
            //             }
            //             return null;
            //           },
            //           hint: Text(
            //             "Select Grade*",
            //             style: appFonts.f14w400Grey,
            //           ),
            //           decoration: const InputDecoration(),
            //           icon: const Icon(Icons.keyboard_arrow_down),
            //           items: List.generate(
            //               grades.length,
            //               (index) => DropdownMenuItem(
            //                   value: grades[index].id.toString(),
            //                   child: Text(grades[index].name.toString()))),
            //           onChanged: (id) {
            //             selectedGrade = id.toString();
            //           });
            //     } else {
            //       return Text(
            //         "Loading Grades...",
            //         style: appFonts.f12w600Grey,
            //       );
            //     }
            //   },
            // ),
            // const SizedBox(
            //   height: 25,
            // ),
            // DropdownButtonFormField(
            //     // value: gender[0],
            //     validator: (value) {
            //       if (value.toString().trim().isEmpty || value == null) {
            //         return "Please Select Gender";
            //       }
            //       return null;
            //     },
            //     hint: Text(
            //       "Select Gender",
            //       style: appFonts.f14w400Grey,
            //     ),
            //     decoration: const InputDecoration(),
            //     icon: const Icon(Icons.keyboard_arrow_down),
            //     items: List.generate(
            //         gender.length,
            //         (index) => DropdownMenuItem(
            //             value: gender[index], child: Text(gender[index]))),
            //     onChanged: (val) {
            //       selectedGender = val.toString();
            //     }),
            // const SizedBox(
            //   height: 25,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 15.0),
            //   child: Text(
            //     "Select Data of Birth",
            //     style: appFonts.f14w400Grey,
            //   ),
            // ),
            // Material(
            //   color: Colors.white,
            //   shadowColor: Colors.grey,
            //   elevation: 5,
            //   borderRadius: BorderRadius.circular(8),
            //   child: CalendarDatePicker(
            //       initialDate: DateTime(DateTime.now().year - 18, 12, 12),
            //       firstDate: DateTime(DateTime.now().year - 90),
            //       lastDate: DateTime.now(),
            //       onDateChanged: (selected) {
            //         setState(() {
            //           selectedDOB = selected.toString().split(" ")[0];
            //         });
            //       }),
            // ),
            // const SizedBox(
            //   height: 25,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isAcceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      isAcceptedTerms = !isAcceptedTerms;
                    });
                  },
                ),
                Expanded(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text:
                                'By continue You agree that You have read and accepted our ',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Get.toNamed('/TermsAndCondition'),
                                  text: 'Terms & Condition ',
                                  style: TextStyle(
                                      color: appColors.brandDark,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline)),
                              const TextSpan(
                                  text: 'and ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Get.toNamed('/PrivacyPolicyScreen'),
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                      color: appColors.brandDark,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline)),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: !isAcceptedTerms,
                    child: Text(
                      'Please agree privacy policy and terms and condition',
                      style: appFonts.f12w600Black
                          .copyWith(color: Colors.red.withOpacity(0.7)),
                    )),
              ],
            ),
            CustomButton(
                title: "Continue",
                onTap: () {
                  //from here that otp functionalities are working i think but here not seeing about that
                  //firebase otp sending method
                  if (key.currentState!.validate() && isAcceptedTerms) {
                    studentModel.name = nameController.text;
                    studentModel.phoneNo = phoneCountroller.text;
                    studentModel.password = passwordController.text;
                    // ProfileRepo().registerStudent(studentModel: studentModel);
                    // Get.toNamed("/otp", arguments: studentModel);
                    Get.to(OtpScreen(
                      phone: int.parse(phoneCountroller.text),
                      studentModel: studentModel,
                      isLogin: false,
                      resetPasswordOrNot: false,
                    ));
                  }
                }),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/SignIn");
                  },
                  child: RichText(
                    text: TextSpan(
                      style: appFonts.f14w400Grey,
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                            style: appFonts.f14w600Black, text: " Sign in"),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
