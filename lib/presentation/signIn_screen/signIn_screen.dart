import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_phone_number/get_phone_number.dart';
import 'package:mcq/core/cubits/registration_cubit/registrations_cubit.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/core/repositories/profile_repo.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/presentation/forgot_password/forgot_password_screen.dart';
import 'package:mcq/presentation/otp_screen/otp_screen.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/loading_button.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_device/safe_device.dart';
import '../../manager/image_manager.dart';
import '../../widgets/custom_textField.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with WidgetsBindingObserver {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isPhoneNumberInThePhone = false;
  Map<String, String> simCardDetails = {};
  bool isPermissionGranted = false;
  String oldNumber = '';
  String _mobileNumber = '';
  String countryCode = '91'; //+1 if emulator
  List<SimCard> number = [];
  Future<void> checkPermission() async {
    MobileNumber.listenPhonePermission((isPermissionGranted) async {
      if (isPermissionGranted) {
        isPermissionGranted = true;
        // initMobileNumberState();
      } else {
        await openAppSettings();
      }
    });
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    } else {
      setState(() {
        isPermissionGranted = true;
      });
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _mobileNumber = (await MobileNumber.mobileNumber)!;
      final simDetails = await MobileNumber.getSimCards!;
      number = simDetails;
      log(_mobileNumber);
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
                      log(sim.number!.substring(2).toString());
                      phoneNumberController.text =
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
  void initState() {
    super.initState();
    // initMobileNumberState();
    WidgetsBinding.instance.addObserver(this);
    // simNumber();
    checkPermission();
  }

  simNumber() async {
    try {
      List<String> list = await GetPhoneNumber().getListPhoneNumber();
      print('getListPhoneNumber result: $list');
    } catch (e) {
      print('getListPhoneNumber error =======$e');
    }
  }

  checkRealDeviceOrNot() async {
    bool isRealDevice = await SafeDevice.isRealDevice;
    if (isRealDevice) {
      setState(() {
        countryCode = '+1';
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              "Welcome Back",
              style: appFonts.f20w600Black,
            ),
            Text(
              "Sign in to continue",
              style: appFonts.f14w400Grey,
            ),
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
                isNumberOnly: true,
                textStyle: appFonts.f18w500Black,
                onTap: () async {
                  await initMobileNumberState();
                  // bool isRealDevice = true;
                  // if(isRealDevice) {
                  //   /// THIS IS FOR FETCHING PHONE NUMBERS (ONLY FOR ANDROID)
                  //   try{
                  //     final SmsAutoFill _autoFill = SmsAutoFill();
                  //     final completePhoneNumber = await _autoFill.hint;
                  //     phoneNumberController.text=completePhoneNumber!.substring(3);
                  //   }catch(e){
                  //     print("========$e");
                  //   }
                  //
                  // }else{
                  //   phoneNumberController.text='9876543210';
                  // }
                },
                // isReadOnly: true,
                label: "Phone number",
                controller: phoneNumberController,
                validator: (value) {
                  isPhoneNumberInThePhone = false;
                  if (value?.length == 10) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        if (oldNumber != phoneNumberController.text.trim()) {
                          Get.to(OtpScreen(
                            phone: int.parse(phoneNumberController.text),
                            studentModel: StudentModel(
                                phoneNo: phoneNumberController.text),
                            isLogin: true,
                            resetPasswordOrNot: false,
                          ));
                          setState(() {
                            oldNumber = phoneNumberController.text;
                          });
                        }
                      },
                    );
                  }
                  return null;
                  // if (emailController.text.trim() != "testmcq@email.com") {
                  //   if (value.toString().trim().isEmpty || value == null) {
                  //     return "Please enter phone-number here";
                  //   } else if (value.trim().length != 10) {
                  //     return "Please enter a valid phone-number";
                  //   }

                  //   for (SimCard sim in number) {
                  //     if (sim.number == countryCode + value) {
                  //       /// valid
                  //       isPhoneNumberInThePhone = true;
                  //       return null;
                  //     }
                  //   }
                  // } else {
                  //   isPhoneNumberInThePhone = true;
                  // }
                  // return null;
                }),
            CustomTextField(
              label: "Password*",
              isPassWord: true,
              controller: passwordController,
              validator: (value) {
                if (value.toString().trim().isEmpty || value == null) {
                  return "Please enter Password here";
                }
                return null;
              },
            ),
            BlocBuilder<RegistrationsCubit, RegistrationsState>(
              buildWhen: (previous, current) => current is SignInState,
              builder: (context, state) => state is! SignInLoadingState
                  ? CustomButton(
                      title: "Sign In",
                      onTap: () {
                        if (key.currentState!.validate() &&
                            isPermissionGranted) {
                          ///todo
                          ProfileRepo()
                              .loginStudent(
                                  verified: true,
                                  studentModel: StudentModel(
                                      phoneNo: phoneNumberController.text,
                                      password: passwordController.text))
                              .then(
                            (status) {
                              if (status) {
                                Get.offAllNamed("/HomeScreen");
                              }
                            },
                          );
                          // BlocProvider.of<RegistrationsCubit>(context)
                          //     .loginStudent(

                          //         studentModel: StudentModel(
                          //             phoneNo:
                          //                 phoneNumberController.text.trim(),
                          //             password:
                          //                 passwordController.text.trim()));

                          // if (isPhoneNumberInThePhone) {
                          //   BlocProvider.of<RegistrationsCubit>(context)
                          //       .loginStudent(
                          //           phoneNumber:
                          //               phoneNumberController.text.trim(),
                          //           studentModel: StudentModel(
                          //               password:
                          //                   passwordController.text.trim()));
                          // } else {
                          //   print('not valid');
                          //   Get.toNamed('/otp', arguments: {
                          //     'student': StudentModel(
                          //         phoneNo: phoneNumberController.text.trim()),
                          //     'isLogin': true
                          //   });
                          // }
                        }
                      })
                  : const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: LoadingButton(
                        height: 45,
                        width: double.infinity,
                        borderRadius: 25,
                      ),
                    ),
            ),
            // Visibility(
            //     visible: !isPermissionGranted,
            //     child: ListTile(
            //       onTap: () {
            //         openAppSettings();
            //       },
            //       title: Text(
            //         'Please enable phone permission',
            //         style: appFonts.f14w600Black
            //             .copyWith(color: Colors.red.withOpacity(0.8)),
            //       ),
            //       trailing: const Icon(Icons.arrow_forward_ios),
            //     )),

            /// FORGET PASSWORD UI
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    // Get.toNamed('/ForgotPasswordScreen');
                    Get.to(ForgotPasswordScreen(
                      studentModel: StudentModel(),
                    ));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: appFonts.f14w400Grey,
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/Registration");
                  },
                  child: RichText(
                      text: TextSpan(
                          style: appFonts.f14w400Grey,
                          text: "Don’t have an account? ",
                          children: [
                        TextSpan(
                            style: appFonts.f14w600Black, text: "Create New")
                      ])),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
