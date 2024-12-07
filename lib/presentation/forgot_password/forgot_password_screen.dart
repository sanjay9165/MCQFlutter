import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mcq/core/models/student_model.dart';
// import 'package:mcq/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/presentation/otp_screen/otp_screen.dart';
import 'package:mcq/presentation/reset_password/reset_password_screen.dart';
import 'package:mcq/widgets/custom_button.dart';
// import 'package:mcq/widgets/custom_snackBar.dart';
// import 'package:mcq/widgets/loading_button.dart';
// import '../../core/cubits/profile_cubit/profile_state.dart';
import '../../widgets/custom_textField.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final StudentModel studentModel;
  const ForgotPasswordScreen({super.key, required this.studentModel});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.brandDark,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Forgot Password',
            style: appFonts.f20w700White,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              appSpaces.spaceForHeight25,
              Text(
                'Please provide phone-number',
                style: appFonts.f16w600Black,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // CustomTextField(
                    //   label: "Email*",
                    //   controller: emailController,
                    //   validator: (value) {
                    //     if (value.toString().trim().isEmpty || value == null) {
                    //       return "Please enter Email here";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    CustomTextField(
                      textStyle: appFonts.f18w500Black,
                      onTap: () async {
                        // bool isRealDevice = await SafeDevice.isRealDevice;
                        // if (isRealDevice) {
                        //   /// THIS IS FOR FETCHING PHONE NUMBERS (ONLY FOR ANDROID)
                        //   final SmsAutoFill _autoFill = SmsAutoFill();
                        //   final completePhoneNumber = await _autoFill.hint;
                        //   phoneNumberController.text = completePhoneNumber!.substring(3);
                        // } else {
                        //   phoneNumberController.text = '9400879756';
                        // }
                      },
                      // isReadOnly: true,
                      label: "Phone number",
                      controller: phoneNumberController,
                      validator: (value) {
                        if (value.toString().trim().isEmpty || value == null) {
                          return "Please enter Email here";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              CustomButton(
                title: 'Send OTP',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Get.to(OtpScreen(
                      phone: int.parse(phoneNumberController.text),
                      isLogin: false,
                      resetPasswordOrNot: true,
                      studentModel:
                          StudentModel(phoneNo: phoneNumberController.text),
                    ));
                    // BlocProvider.of<ProfileCubit>(context)
                    //     .checkingEmailAndPhoneMatch(
                    //         email: emailController.text.trim(),
                    //         phone: phoneNumberController.text.trim());
                  }
                },
              ),
              appSpaces.spaceForHeight25,
              // BlocConsumer<ProfileCubit, ProfileState>(
              //   buildWhen: (previous, current) =>
              //       current is ForgotPasswordState,
              //   listener: (context, state) {
              //     if (state is ForgotPasswordErrorState) {
              //       customSnackBar(
              //           title: 'Error',
              //           message: state.error ??
              //               'Something went wrong please try again',
              //           isError: true);
              //     } else if (state is ForgotPasswordSuccessState) {
              //       if (state.isMatched) {
              //         Get.toNamed('/ResetPasswordScreen', arguments: {
              //           'phoneNumber': phoneNumberController.text,
              //           'email': emailController.text
              //         });
              //       } else {
              //         customSnackBar(
              //             title: 'Wrong Credential',
              //             message: " phone-number not matched",
              //             isError: true);
              //       }
              //     }
              //   },
              //   builder: (context, state) {
              //     return state is! ForgotPasswordLoadingState
              //         ? CustomButton(
              //             title: 'Send OTP',
              //             onTap: () {
              //               if (_formKey.currentState!.validate()) {
              //                 // BlocProvider.of<ProfileCubit>(context)
              //                 //     .checkingEmailAndPhoneMatch(
              //                 //         email: emailController.text.trim(),
              //                 //         phone: phoneNumberController.text.trim());
              //               }
              //             },
              //           )
              //         : const LoadingButton(
              //             height: 45,
              //           );
              //   },
              // )
            ],
          ),
        ));
  }
}
