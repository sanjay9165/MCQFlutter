
import 'package:flutter/material.dart';

import '../../manager/font_manager.dart';
import '../../manager/space_manager.dart';
import '../../widgets/custom_scaffold.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> privacyPolicyTitles = [
      "Privacy Policy",
      "Information Collection and Use",
      "Google Play Services",
      "Service Providers",
      "Security",
      "Cancellation & Refund Policy",
      "Refund Policy",
      "Terms & Conditions",
      "USE OF CONTENT",
      "Security Rules",
      "General Rules",
      "INDEMNITY",
      "LIABILITY",
      "DISCLAIMER OF CONSEQUENTIAL DAMAGES"
    ];

// List of Contents for Privacy Policy
    List<String> privacyPolicyContents = [
      "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at STUDY MCQ KANNADA APP unless otherwise defined in this Privacy Policy.",
      "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to your name, email, and phone number. The information that we request will be retained by us and used as described in this privacy policy. The app does use third-party services that may collect information used to identify you.",
      "Log Data: We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.",
      "We may employ third-party companies and individuals due to the following reasons:\n- To facilitate our Service;\n- To provide the Service on our behalf;\n- To perform Service-related services; or\n- To assist us in analyzing how our Service is used.\nWe want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
      "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.",
      "There is no cancellation of orders placed E-Books, PDFs, Audio-visual material of this app if any purchased under Instant Electronic Delivery / Instant Downloads. No refund is made for such purchases. Cancellations in case of printed material will be considered only if the request is made within 2 hours of placing an order. However, the cancellation request will not be entertained if the orders have been communicated to the vendors/merchants and they have initiated the process of shipping them. No cancellations are entertained for those products that the STUDY MCQ KANNADA marketing team has obtained on special occasions like Pongal, Diwali, Valentine’s Day etc. These are limited occasion offers and therefore cancellations are not possible.",
      "When you buy our services, your purchase is covered by our 20-day money-back guarantee. If you are, for any reason, not received your access to the documents / system / late delivery (only you notified before that no need of purchase after due date), then you can communicate with us for refund. We serve quality of services that we use ourselves every day and have thousands of satisfied customers worldwide, and our support is second to none. That is why we can afford to back our services with this special guarantee. To request a refund, simply contact us with your service details within twenty (20) days of your purchase. Please include your order / application number and tell us proof and proper reason why you’re requesting a refund – we take customer feedback very seriously and use it to constantly improve our products and quality of service. Refunds are not being provided for services delivered in full.",
      "The terms “We” / “Us” / “Our”/”Company” individually and collectively refer to STUDY MCQ KANNADA and the terms “Visitor” ”User” refer to the users. Here are the terms & conditions under which you (user) can use this application (STUDY MCQ KANNADA ). If you don’t accept the terms & conditions, we would request you to kindly uninstall this application.",
      "All logos, brands, marks headings, labels, names, signatures, numerals, shapes or any combinations thereof, appearing in this app, except as otherwise noted, are properties either owned, or used under licence, by STUDY MCQ KANNADA. The use of these properties or any other content on this application, except as provided in these terms and conditions is strictly prohibited.\nYou may not sell or modify the content of this app or reproduce, display, publicly perform, distribute, or otherwise use the materials in any way for any public or commercial purpose without STUDY MCQ KANNADA or respective organisation’s or entity’s written permission.",
      "Users are prohibited from violating or attempting to violate the security of this application, including, without limitation, (1) accessing data not intended for such user or logging into a server or account which the user is not authorised to access, (2) attempting to probe, scan or test the vulnerability of a system or network or to breach security or authentication measures without proper authorisation, (3) attempting to interfere with service to any user, host or network, including, without limitation, via means of submitting a virus or “Trojan horse” to the app code, overloading, “flooding”, “mail bombing” or “crashing”, or (4) sending unsolicited electronic mail, including promotions and/or advertising of products or services. Violations of system or network security may result in civil or criminal liability. STUDY MCQ KANNADA will have the right to investigate occurrences that they suspect as involving such violations and will have the right to involve, and cooperate with, law enforcement authorities in prosecuting users who are involved in such violations.",
      "Users may not use app in order to transmit, distribute, store or destroy material (a) that could constitute or encourage conduct that would be considered a criminal offence or violate any applicable law or regulation, (b) in a manner that will infringe the copyright, trademark, trade secret or other intellectual property rights of others or violate the privacy or publicity of other personal rights of others, or (c) that is libellous, defamatory, pornographic, profane, obscene, threatening, abusive or hateful.",
      "The User unilaterally agree to indemnify and hold harmless, without objection, the Company, its officers, directors, employees and agents from and against any claims, actions and/or demands and/or liabilities and/or losses and/or damages whatsoever arising from or resulting from their use of STUDY MCQ KANNADA or their breach of the terms.",
      "User agrees that neither STUDY MCQ KANNADA nor its group companies, directors, officers or employee shall be liable for any direct or / and indirect or/and incidental or/and special or/and consequential or/and exemplary damages, resulting from the use or/and the inability to use the service or/and for cost of procurement of substitute goods or/and services or resulting from any goods or/and data or/and information or/and services purchased or/and obtained or/and messages received or/and transactions entered into through or/and from the service or/and resulting from unauthorized access to or/and alteration of user’s transmissions or/and data or/and arising from any other matter relating to the service, including but not limited to, damages for loss of profits or/and use or/and data or other intangible, even if Company has been advised of the possibility of such damages.\nUser further agrees that STUDY MCQ KANNADA shall not be liable for any damages arising from interruption, suspension or termination of service, including but not limited to direct or/and indirect or/and incidental or/and special consequential or/and exemplary damages, whether such interruption or/and suspension or/and termination was justified or not, negligent or intentional, inadvertent or advertent.\nUser agrees that STUDY MCQ KANNADA shall not be responsible or liable to user, or anyone, for the statements or conduct of any third party of the service. In sum, in no event shall STUDY MCQ KANNADA total liability to the User for all damages or/and losses or/and causes of action exceed the amount paid by the User to STUDY MCQ KANNADA, if any, that is related to the cause of action.",
      "In no event shall STUDY MCQ KANNADA or any parties, organizations or entities associated with the corporate brand name us or otherwise, mentioned at our website or application shall be liable for any damages whatsoever (including, without limitations, incidental and consequential damages, lost profits, or damage to computer hardware or loss of data information or business interruption) resulting from the use or inability to use the app or app material, whether based on warranty, contract, tort, or any other legal theory, and whether or not, such organization or entities were advised of the possibility of such damages."
    ];
    return CustomScaffold(
      content: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(child: ListView.builder(
            itemCount: privacyPolicyTitles.length,
            itemBuilder: (context, index) {

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index<9?'0':''}${index + 1}. ${privacyPolicyTitles[index]}",
                    style: appFonts.f16w600Black,
                  ),

                   Text(privacyPolicyContents[index]),
                  appSpaces.spaceForHeight10
                ],
              );
            },
          )),
        ],
      ),
      headerTitle: 'Privacy Policy',
      headerIconBg:const Color(0xFFD6F6CA),
      headerIcon:const Icon(
        Icons.security,
        color: Color(0xFF409B21),
        size: 40,
      ),
    );
  }
}
