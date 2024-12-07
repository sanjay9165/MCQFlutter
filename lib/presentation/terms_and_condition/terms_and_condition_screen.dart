import 'package:flutter/material.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/widgets/custom_scaffold.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      content: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 14,
            itemBuilder: (context, index) {

              List<String> titles = [
                "Acceptance of Terms",
                "Ownership",
                "Use of the App",
                "Content",
                "Accuracy of Questions",
                "Source of Questions",
                "Syllabus and Updates",
                "Subscription and Pricing",
                "User Conduct",
                "Limitation of Liability",
                "Changes to Terms",
                "Governing Law",
                "Contact Information",
                "Subscription and Admin Control"
              ];

              List<String> termsAndConditions = [
                "By accessing or using the 'Study Mcq Kannada' app, you agree to be bound by these Terms and Conditions. If you do not agree to all the terms and conditions, then you may not access the app or use any services.",
                "The 'Study Mcq Kannada' app is owned and operated by HGA Academy. All rights not expressly granted herein are reserved to HGA Academy.",
                "You agree to use the app solely for educational purposes. You are responsible for maintaining the confidentiality of your account and password.",
                "The 'Study Mcq Kannada' app provides general knowledge questions in the Kannada language sourced from question papers of competitive examinations conducted by the central government, state government, various universities, and boards. Questions are carefully examined and included in the app. Users can report errors through the admin login on app for review by the expert team.",
                "Most questions in the app are from past competitive exams, and the correct answers correspond to official answers provided by the relevant authorities. Current affairs questions are relevant to the year in which they were asked.",
                "The questions in this app are not solely from any online source or single book but are a compilation of past exam questions.",
                "As the app is updated regularly, the syllabus, lessons, and question papers are subject to change. Users may add, modify, or remove syllabus, lessons, or question papers without prior notice.",
                "The subscription amount, discount offers, referral amounts, and pricing structure of the app may vary over time. The admin reserves the right to change these at any time without prior notice.",
                "Users agree to use the app responsibly and not to engage in any unlawful activities or violate the rights of others.",
                "In no event shall HGA Academy be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with the use of the app.",
                "HGA Academy reserves the right to modify or revise these Terms and Conditions at any time without prior notice. Your continued use of the app following the posting of changes constitutes your acceptance of such changes.",
                "These Terms and Conditions shall be governed by and construed in accordance with the laws of [government of India], without regard to its conflict of law provisions.",
                "If you have any questions or concerns about these Terms and Conditions, please contact us at [kannadastudymcq@gmail.com].",
                "Users must provide a mobile number that corresponds to the device used for access. Each subscription is valid for use on one device only. Access to the app will be restricted if the provided mobile number does not match the device used for access."
              ];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index<9?'0':''}${index + 1}. ${titles[index]}",
                    style: appFonts.f16w600Black,
                  ),

                   Text(termsAndConditions[index]),
                  appSpaces.spaceForHeight10
                ],
              );
            },
          )),
        ],
      ),
      headerTitle: 'Terms and Condition',
      headerIconBg: const Color(0xFFF6F1CA),
      headerIcon: const Icon(
        Icons.privacy_tip,
        color: Color(0xFFD38C07),
        size: 40,
      ),
    );
  }
}
