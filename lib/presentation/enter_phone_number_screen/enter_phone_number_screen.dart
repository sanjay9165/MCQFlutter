import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_textField.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/custom_appBar.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  final StudentModel studentModel;

  const EnterPhoneNumberScreen({super.key, required this.studentModel});

  @override
  State<EnterPhoneNumberScreen> createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  final key = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMobileNumberState();
    checkPermission();

  }

  @override
  void dispose() {
   phoneController.dispose();
    super.dispose();
  }

  Future<void> checkPermission() async {
    MobileNumber.listenPhonePermission((isPermissionGranted) async {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {
        await openAppSettings();
      }
    });
  }

  Future<void> noPermissionGrantedAlert() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Please Allow Phone Permission'),
        actions: [
          CustomButton(
            title: 'Ok',
            onTap: () {
              checkPermission();
            },
          )
        ],
      ),
    );
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    } else {}
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          children: [
            const CustomAppBar(
              title: "Verification",
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Enter your mobile number to verify your account",
              style: appFonts.f14w400Grey,
              textAlign: TextAlign.center,
            ),

            CustomTextField(
              textStyle: appFonts.f16w600Black,
              // isReadOnly: true,
              //   onTap: ()async {
              //     bool isRealDevice = await SafeDevice.isRealDevice;
              //     if(isRealDevice) {
              //       /// THIS IS FOR FETCHING PHONE NUMBERS (ONLY FOR ANDROID)
              //         final SmsAutoFill _autoFill = SmsAutoFill();
              //         final completePhoneNumber = await _autoFill.hint;
              //         phoneController.text=completePhoneNumber!.substring(3);
              //     }
              //   },
                controller: phoneController,
                label: "Enter Mobile number*",
                validator: (val) {
                  if (val == null || val.toString().trim().isEmpty) {
                    return "Please enter number";
                  }
                  return null;
                }),
            CustomButton(
                title: "Send Otp",
                onTap: () {
                  if (key.currentState!.validate()) {
                    widget.studentModel.phoneNo = phoneController.text;
                    Get.toNamed("/otp", arguments: {'student':widget.studentModel,'isLogin':false});
                  }
                })
          ],
        ),
      ),
    );
  }
}
