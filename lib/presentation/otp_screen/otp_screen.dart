import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/core/repositories/profile_repo.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/presentation/home/home_screen.dart';
import 'package:mcq/presentation/reset_password/reset_password_screen.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import '../../core/cubits/registration_cubit/registrations_cubit.dart';
import '../../manager/font_manager.dart';
import '../../widgets/custom_appBar.dart';
import '../../widgets/custom_snackBar.dart';
import '../../widgets/loading_button.dart';

class OtpScreen extends StatefulWidget {
  final StudentModel studentModel;
  final bool isLogin;
  final bool resetPasswordOrNot;
  final int? phone;
  const OtpScreen(
      {super.key,
      required this.studentModel,
      required this.isLogin,
      required this.resetPasswordOrNot,
      this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  String? verId;
  final formKey = GlobalKey<FormState>();
  String otp = '';
  late Timer timer;
  int secondsRemaining = 30;
  bool enableResend = false;
  @override
  void initState() {
    secondsRemaining = widget.isLogin ? 90 : 30;
    super.initState();
    resentTimer();
    sendOtp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final String phoneNumber = widget.studentModel.phoneNo.toString();

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

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              const CustomAppBar(
                title: "Verification",
              ),
              appSpaces.spaceForHeight25,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Enter the 6 digit code we have sent "
                  "+91 ${widget.phone}",
                  style: appFonts.f14w400Grey,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: formKey,
                child: Pinput(
                  // readOnly: true,
                  // autofocus: true,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  validator: (value) {
                    if (value == '') {
                      return 'Please Enter OTP';
                    } else if (value!.length < 6) {
                      return 'Please Enter a Valid OTP';
                    } else {
                      return null;
                    }
                  },
                  length: 6,
                  pinAnimationType: PinAnimationType.slide,
                  controller: controller,

                  ///todo
                  // readOnly: true,
                  // focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  showCursor: true,
                  cursor: cursor,
                  submittedPinTheme: submittedPinTheme,
                  preFilledWidget: preFilledWidget,
                  onCompleted: (pin) {
                    if (pin == otp) {
                      if (widget.resetPasswordOrNot) {
                        Get.to(ResetPasswordScreen(phoneNumber: widget.phone!));
                      } else if (widget.isLogin) {
                        timer.cancel();
                        Get.back();
                        // ProfileRepo().loginStudent(
                        //     studentModel: widget.studentModel, verified: true);
                        // Get.offAllNamed("/HomeScreen");
                      } else {
                        BlocProvider.of<RegistrationsCubit>(context)
                            .registerStudent(studentModel: widget.studentModel);
                      }
                      // ProfileRepo()
                      //     .registerStudent(studentModel: widget.studentModel);

                      // Get.offAllNamed("/HomeScreen");
                      //   if(widget.isLogin){
                      //   BlocProvider.of<RegistrationsCubit>(context).loginStudent(
                      //       phoneNumber: widget.studentModel.phoneNo!, studentModel: widget.studentModel);
                      // }else{
                      //     BlocProvider.of<RegistrationsCubit>(context)
                      //         .registerStudent(studentModel: widget.studentModel);
                      //   }
                    }
                    if (otp == pin) {
                      customSnackBar(
                          title: 'Success',
                          message: 'Phone validation success');
                    }
                  },
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!widget.isLogin) ...{
                    GestureDetector(
                      onTap: () {
                        if (secondsRemaining == 0) {
                          sendOtp();
                          setState(() {
                            secondsRemaining = 30;
                          });
                        }
                      },
                      child: Text(
                        'RESEND OTP',
                        style: secondsRemaining != 0
                            ? appFonts.f14w600Grey
                            : appFonts.f14w600Black
                                .copyWith(color: appColors.brandDark),
                      ),
                    ),
                  },
                  appSpaces.spaceForWidth10,
                  Text(
                    formatDuration(secondsRemaining),
                    style: appFonts.f14w600Black,
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
        bottomSheet: !widget.isLogin
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : BlocConsumer<RegistrationsCubit, RegistrationsState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            customSnackBar(
                                title: 'Registration Success',
                                message:
                                    'Your Registration Completed Please Login with Email and Password');
                            Get.offAllNamed("/SignIn");
                          } else if (state is RegisterErrorState) {
                            Get.back();
                            customSnackBar(
                                title: 'Failed',
                                message: state.error,
                                isError: true);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            title: "Continue",
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (otp == controller.text) {
                                  customSnackBar(
                                      title: 'Success',
                                      message: 'Phone validation success');
                                  BlocProvider.of<RegistrationsCubit>(context)
                                      .registerStudent(
                                          studentModel: widget.studentModel);
                                }
                              }
                            },
                          );
                        },
                      ),
              )
            : SizedBox()
        // BlocConsumer<RegistrationsCubit, RegistrationsState>(
        //     listener: (context, state) {},
        //     buildWhen: (previous, current) => current is SignInState,
        //     builder: (context, state) => state is! SignInLoadingState
        //         ? CustomButton(
        //             title: "Sign In",
        //             onTap: () {
        //               if (formKey.currentState!.validate()) {
        //                 if (otp == controller.text) {
        //                   timer.cancel();
        //                   customSnackBar(
        //                       title: 'Success',
        //                       message:
        //                           'Phone validation success, now you can login with password');
        //                   Get.back();
        //                   // BlocProvider.of<RegistrationsCubit>(context)
        //                   //     .loginStudent(
        //                   //         verified: true,
        //                   //         studentModel: widget.studentModel);
        //                 }
        //               }
        //             })
        //         : const Padding(
        //             padding: EdgeInsets.only(top: 15),
        //             child: LoadingButton(
        //               height: 45,
        //               width: double.infinity,
        //               borderRadius: 25,
        //             ),
        //           ),
        //   ),
        );
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void resentTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else if (widget.isLogin && secondsRemaining == 0) {
        Get.back();
        customSnackBar(
            title: 'Time Over',
            message:
                'Phone validation not completed, you can login via password',
            isError: true);
        timer.cancel();
      }
    });
  }

  sendOtp() async {
    final random = Random();
    int otpValue = random.nextInt(900000) + 100000;

    ///todo
    print(otpValue);
    setState(() {
      otp = otpValue.toString();
    });
    try {
      final response = await post(Uri.parse(
          'https://2factor.in/API/V1/436e5fbe-9340-11ee-8cbb-0200cd936042/SMS/${widget.studentModel.phoneNo}/$otpValue/SMSOTP1'));
      if (response.statusCode == 200) {
        customSnackBar(
            title: 'Otp Send', message: 'Otp Successfully send to via sms');
      } else if (response.statusCode == 400) {
        customSnackBar(
            title: 'No valid', message: 'Please check you phone-number');
      } else {
        customSnackBar(
            title: 'Error', message: 'Something went wrong please try again');
      }
    } catch (e) {
      if (kDebugMode) {
        print('=================error on$e');
      }
      customSnackBar(
          title: 'Error', message: 'Something went wrong please try again');
    }
  }
}
