import 'package:get/get.dart';
import 'package:mcq/presentation/add_bank_details/add_bank_detatils_screen.dart';
import 'package:mcq/presentation/forgot_password/forgot_password_screen.dart';
import 'package:mcq/presentation/mcq_list/mcq_list_screen.dart';
import 'package:mcq/presentation/edit_profile/edit_profile_screen.dart';
import 'package:mcq/presentation/enter_phone_number_screen/enter_phone_number_screen.dart';
import 'package:mcq/presentation/home/home_screen.dart';
import 'package:mcq/presentation/invite_friends/invite_friends.dart';
import 'package:mcq/presentation/notification/notifications_screen.dart';
import 'package:mcq/presentation/offline_screen/offline_screen.dart';
import 'package:mcq/presentation/otp_screen/otp_screen.dart';
import 'package:mcq/presentation/payment_loading/payment_loading_screen.dart';
import 'package:mcq/presentation/privacy_policy/privacy_policy_screen.dart';
import 'package:mcq/presentation/profile/profile_screen.dart';
import 'package:mcq/presentation/ongoing_tests_list/ongoing_tests_list_screen.dart';
import 'package:mcq/presentation/onBoarding_screen/onBoarding_screen.dart';
import 'package:mcq/presentation/registeration_screen/registration_screen.dart';
import 'package:mcq/presentation/reset_password/reset_password_screen.dart';
import 'package:mcq/presentation/review/review_screen.dart';
import 'package:mcq/presentation/review_show/review_show_screen.dart';
import 'package:mcq/presentation/select_plan/select_plan_screen.dart';
import 'package:mcq/presentation/signIn_screen/signIn_screen.dart';
import 'package:mcq/presentation/splash/splash_screen.dart';
import 'package:mcq/presentation/subscription/subscription_screen.dart';
import 'package:mcq/presentation/terms_and_condition/terms_and_condition_screen.dart';
import 'package:mcq/presentation/wallet_balance/wallet_balance_screen.dart';
import '../presentation/QP_pending_and_completed_exam/QP_pending_and_completed_screen.dart';
import '../presentation/pending_and_completed_test/pending_and_completed_screen.dart';
import '../presentation/subjects/subjects_screen.dart';

List<GetPage> appRouting() {
  return [
    GetPage(
      name: '/',
      page: () => const SplashScreen(),
    ),
    GetPage(name: '/SignIn', page: () => const SignInScreen()),
    GetPage(name: '/Registration', page: () => const RegistrationScreen()),
    GetPage(
      name: '/Verification',
      page: () => EnterPhoneNumberScreen(
        studentModel: Get.arguments,
      ),
    ),
    // GetPage(
    //   name: '/otp',
    //   page: () => OtpScreen(resetPasswordOrNot: argume,
    //     studentModel: Get.arguments['student'],
    //     isLogin: Get.arguments['isLogin'],
    //   ),
    // ),
    GetPage(name: '/EditProfile', page: () => const EditProfileScreen()),
    GetPage(
      name: '/Subscription',
      page: () => const SubscriptionScreen(),
    ),
    GetPage(
      name: '/InviteFriends',
      page: () => const InviteFriendsScreen(),
    ),
    GetPage(
      name: '/McqListScreen',
      page: () => McqListScreen(
        subject: Get.arguments['subject'],
        chapterModel: Get.arguments['chapterModel'],
        examModel: Get.arguments['examModel'],
      ),
    ),
    GetPage(
        name: '/Review',
        page: () => ReviewScreen(
              subId: Get.arguments['subId'],
              chapId: Get.arguments['chapId'],
              examId: Get.arguments['examId'],
              percentage: Get.arguments['percentage'],
            )),

    GetPage(
      name: '/HomeScreen',
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: '/Onboarding',
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: '/PendingAndCompletedScreen',
      page: () => PendingAndCompletedScreen(
        subjectModel: Get.arguments,
      ),
    ),
    GetPage(
      name: '/QPPendingAndCompletedScreen',
      page: () => QPPendingAndCompletedScreen(
        subjectModel: Get.arguments,
      ),
    ),
    GetPage(
      name: '/OngoingTestListScreen',
      page: () => OngoingTestListScreen(testList: Get.arguments),
    ),
    GetPage(
      name: '/SubjectListScreen',
      page: () => SubjectListScreen(subjectList: Get.arguments),
    ),
    GetPage(
      name: '/Profile',
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: '/Invite',
      page: () => const InviteFriendsScreen(),
    ),
    GetPage(
      name: '/ReviewShowScreen',
      page: () => ReviewShowScreen(
        isChapter: Get.arguments['isChapter'],
        reviewResults: Get.arguments['reviewResults'],
        percentage: Get.arguments['percentage'],
        currentQuestion: Get.arguments['currentQuestion'],
      ),
    ),
    GetPage(
      name: '/SelectPlanScreen',
      page: () => const SelectPlanScreen(),
    ),
    // GetPage(
    //   name: '/ExamListScreen',
    //   page: () =>
    //       ExamListScreen(
    //     subjectModel: Get.arguments,
    //   ),
    // ),
    // GetPage(
    //   name: '/QuestionsMCQListScreen',
    //   page: () => QuestionsMCQListScreen(
    //     examModel: Get.arguments,
    //   ),
    // ),
    GetPage(
      name: '/Notification',
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: '/Offline',
      page: () => const OfflineScreen(),
    ),
    GetPage(
      name: '/PaymentLoading',
      page: () => PaymentLoadingScreen(
        paymentDetails: Get.arguments['paymentDetails'],
        planId: Get.arguments['planId'],
      ),
    ),
    GetPage(
      name: '/WalletBalance',
      page: () => const WalletBalanceScreen(),
    ),
    GetPage(
      name: '/AddBankDetails',
      page: () => AddBankDetailsScreen(
        isEdit: Get.arguments['isEdit'],
        bankDetails: Get.arguments['bankDetails'],
      ),
    ),
    GetPage(
      name: '/TermsAndCondition',
      page: () => const TermsAndCondition(),
    ),
    GetPage(
        name: '/PrivacyPolicyScreen', page: () => const PrivacyPolicyScreen()),
    // GetPage(name: '/ForgotPasswordScreen', page: () => const ForgotPasswordScreen(),),
    GetPage(
      name: '/ResetPasswordScreen',
      page: () =>
          ResetPasswordScreen(phoneNumber: Get.arguments['phoneNumber']),
    )
    // GetPage(
    //   name: '/ExamListScreen',
    //   page: () =>
    //       ExamListScreen(
    //     subjectModel: Get.arguments,
    //   ),
    // ),
    // GetPage(
    //   name: '/QuestionsMCQListScreen',
    //   page: () => QuestionsMCQListScreen(
    //     examModel: Get.arguments,
    //   ),
    // ),
  ];
}
