import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import 'package:mcq/widgets/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                appImages.onBoardingImage,
                width: getDimension(context: context, horizontalPadding: 30).w,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  "Learning Made Easy, Testing Made Fun!",
                  style: appFonts.f20w600Black,
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButton(
                  title: "Sign In",
                  onTap: () {
                    Get.toNamed("/SignIn");
                  }),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed("/Register");
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
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 15),
                  child: InkWell(
                    onTap: () {},
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: appFonts.f10w400Grey,
                            text:
                                "By continue You agree that You have read and accepted our ",
                            children: [
                              TextSpan(
                                  style: appFonts.f10w700Black,
                                  text: " Terms & Conditions "),
                              TextSpan(
                                  style: appFonts.f10w400Grey, text: "and "),
                              TextSpan(
                                  style: appFonts.f10w700Black,
                                  text: "Privacy Policy"),
                            ])),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
