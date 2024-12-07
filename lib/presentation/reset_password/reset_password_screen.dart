import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_state.dart';
import 'package:mcq/core/repositories/profile_repo.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import 'package:mcq/widgets/custom_textField.dart';
import 'package:pinput/pinput.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.phoneNumber});
  final int phoneNumber;
  // final int email
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final otpForm = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool isOtpVerified = false;
  String otp = "";
  int secondsRemaining = 30;
  TextEditingController newPasswordController = TextEditingController();
  final passwordForm = GlobalKey<FormState>();
  late Timer timer;
  @override
  void initState() {
    super.initState();
    // sendOtp();
    resentTimer();
  }

  @override
  Widget build(BuildContext context) {
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: appColors.brandDark,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    const defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(),
    );

    PinTheme submittedPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
    );
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
          'Reset Password',
          style: appFonts.f20w700White,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: ListView(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20.0),
            //   child: Text(
            //     "Enter the 6 digit code we have sent "
            //     "+91 ${widget.phoneNumber}",
            //     style: appFonts.f14w400Grey,
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // Form(
            //   key: otpForm,
            //   child: Pinput(
            //     androidSmsAutofillMethod:
            //         AndroidSmsAutofillMethod.smsUserConsentApi,
            //     validator: (value) {
            //       if (value == '') {
            //         return 'Please Enter OTP';
            //       } else if (value!.length < 6) {
            //         return 'Please Enter a Valid OTP';
            //       } else {
            //         return null;
            //       }
            //     },
            //     length: 6,
            //     pinAnimationType: PinAnimationType.slide,
            //     controller: otpController,
            //     // focusNode: focusNode,
            //     defaultPinTheme: defaultPinTheme,
            //     showCursor: true,
            //     cursor: cursor,
            //     readOnly: true,
            //     submittedPinTheme: submittedPinTheme,
            //     preFilledWidget: preFilledWidget,
            //     onCompleted: (pin) {
            //       if (otp == pin) {
            //         setState(() {
            //           isOtpVerified = true;
            //         });
            //         customSnackBar(
            //             title: 'Success',
            //             message: 'OTP verification success, set new password');
            //       }
            //     },
            //   ),
            // // ),
            // appSpaces.spaceForHeight25,
            // !isOtpVerified
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               if (secondsRemaining == 0) {
            //                 sendOtp();
            //                 setState(() {
            //                   secondsRemaining = 30;
            //                 });
            //               }
            //             },
            //             child: Text(
            //               'RESEND OTP',
            //               style: secondsRemaining != 0
            //                   ? appFonts.f14w600Grey
            //                   : appFonts.f14w600Black
            //                       .copyWith(color: appColors.brandDark),
            //             ),
            //           ),
            //           appSpaces.spaceForWidth10,
            //           Text(
            //             secondsRemaining.toString(),
            //             style: appFonts.f14w600Black,
            //           )
            //         ],
            //       )
            //     : const SizedBox(),
            // appSpaces.spaceForHeight25,
            // CustomButton(
            //   backGroundColor:
            //       isOtpVerified ? Colors.grey.withOpacity(0.5) : null,
            //   title: 'Verify OTP',
            //   onTap: () {
            //     if (!isOtpVerified && otpForm.currentState!.validate()) {
            //       if (otp == otpController.text.trim()) {
            //         setState(() {
            //           isOtpVerified = true;
            //         });
            //         customSnackBar(
            //             title: 'Success',
            //             message: 'OTP verification success, set new password');
            //       } else {
            //         customSnackBar(
            //             title: 'Failed',
            //             message:
            //                 'OTP not verified please check otp and phone number',
            //             isError: true);
            //       }
            //     }
            //   },
            // ),
            // const Divider(),
            Column(
              children: [
                Text(
                  'Set New password',
                  style: appFonts.f16w600Black.copyWith(
                      color: isOtpVerified
                          ? Colors.black
                          : Colors.grey.withOpacity(0.5)),
                ),
                appSpaces.spaceForHeight20,
                Form(
                  key: passwordForm,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: newPasswordController,
                        // isReadOnly: !isOtpVerified,
                        onTap: () {
                          // if (!isOtpVerified) {
                          //   customSnackBar(
                          //       title: 'Verify OTP',
                          //       message: "Please verify OTP first");
                          // }
                        },
                        label: 'New password',
                        validator: (value) {
                          if (value.toString().trim().isEmpty ||
                              value == null) {
                            return "Please enter password here";
                          } else if (value.length < 6) {
                            return "Password must have 6 digit";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        // onTap: () {
                        //   if (!isOtpVerified) {
                        //     customSnackBar(
                        //         title: 'Verify OTP',
                        //         message: "Please verify OTP first");
                        //   }
                        // },
                        // isReadOnly: !isOtpVerified,
                        label: 'Confirm password',
                        validator: (value) {
                          if (value.toString().trim().isEmpty ||
                              value == null) {
                            return "Please confirm password";
                          } else if (newPasswordController.text.trim() !=
                              value.trim()) {
                            return "This password doesn't match with above one";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                appSpaces.spaceForHeight20,
                BlocConsumer<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
                      current is ResetPasswordState,
                  listener: (context, state) {
                    if (state is ResetPasswordErrorState) {
                      customSnackBar(
                          title: 'Failed',
                          message: 'Reset password failed, try again later',
                          isError: true);
                    } else if (state is ResetPasswordSuccessState) {
                      customSnackBar(
                          title: 'Updated', message: 'Password reset success');
                      Get.offAllNamed("/HomeScreen");
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      // textStyle: !isOtpVerified
                      //     ? appFonts.f16w600Black
                      //         .copyWith(color: Colors.black.withOpacity(0.5))
                      //     : null,
                      // backGroundColor:
                      //     !isOtpVerified ? Colors.grey.withOpacity(0.5) : null,
                      title: 'Confirm',
                      onTap: () {
                        if (passwordForm.currentState!.validate()) {
                          ProfileRepo().resetPassword(
                              newPassword: newPasswordController.text.trim(),
                              phone: widget.phoneNumber);
                          // BlocProvider.of<ProfileCubit>(context).resetPassword(
                          //     newPassword: newPasswordController.text.trim(),
                          //     phone: widget.phoneNumber);
                        }
                        // else if (!isOtpVerified) {
                        //   customSnackBar(
                        //       title: 'Verify OTP',
                        //       message: "Please verify OTP first");
                        // }
                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void resentTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  sendOtp() async {
    final random = Random();
    int otpValue = random.nextInt(900000) + 100000;
    setState(() {
      otp = otpValue.toString();
      print(otp);
    });
    final response = await post(Uri.parse(
        'https://2factor.in/API/V1/436e5fbe-9340-11ee-8cbb-0200cd936042/SMS/${widget.phoneNumber}/$otpValue/SMSOTP1'));
    if (response.statusCode == 200) {
      customSnackBar(
          title: 'Otp Send', message: 'Otp Successfully send to via sms');
    } else {
      customSnackBar(
          title: 'Error', message: 'Something went wrong please try again');
    }
  }
}
