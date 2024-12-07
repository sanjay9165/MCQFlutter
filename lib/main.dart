// ignore_for_file: unused_local_variable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcq/core/cubits/QP_subjects_cubit/qp_subjects_cubit.dart';
import 'package:mcq/core/cubits/completed_exam_cubit/completed_exam_cubit.dart';
import 'package:mcq/core/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:mcq/core/cubits/grade_cubit/grade_cubit.dart';
import 'package:mcq/core/cubits/mcq_cubit/mcq_cubit.dart';
import 'package:mcq/core/cubits/notification_cubit/notification_cubit.dart';
import 'package:mcq/core/cubits/pending_cubit/pending_cubit.dart';
import 'package:mcq/core/cubits/plans_cubit/plans_cubit.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:mcq/core/cubits/registration_cubit/registrations_cubit.dart';
import 'package:mcq/core/cubits/review_cubit/review_cubit.dart';
import 'package:mcq/core/cubits/splash_cubit/splash_cubit.dart';
import 'package:mcq/core/cubits/wallet_cubit/wallet_cubit.dart';
import 'package:mcq/core/repositories/mcq_repo.dart';
import 'package:mcq/core/repositories/notification_repo.dart';
import 'package:mcq/core/repositories/plans_repo.dart';
import 'package:mcq/core/repositories/review_repo.dart';
import 'package:mcq/core/repositories/wallet_repo.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/route_manager.dart';
import 'core/app_urls.dart';
import 'core/cubits/QP_completed_exam_cubit/QP_completed_exam_cubit.dart';
import 'core/cubits/QP_mcq_cubit/qp_mcq_cubit.dart';
import 'core/cubits/QP_pending_cubit/QP_pending_cubit.dart';
import 'core/cubits/search_cubit/search_cubit.dart';
import 'core/repositories/profile_repo.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

String boxName = 'pending_e';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await dotenv.load(fileName: ".env");
  await GetStorage.init();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider:
        isDev ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  );
  bool isUserLogin = await checkingUserLoginOrNot();
//
  runApp(MyApp(
    isUserLogin: isUserLogin,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  final bool isUserLogin;
  const MyApp({super.key, required this.isUserLogin});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    checkConnectivity();
    final subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      bool connected = false;
      if (result == ConnectivityResult.none) {
        Get.toNamed('/Offline');
        connected = false;
      } else if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ProfileRepo()),
        RepositoryProvider(create: (context) => McqRepo()),
        RepositoryProvider(
          create: (context) => ReviewRepo(),
        ),
        RepositoryProvider(
          create: (context) => NotificationsRepo(),
        ),
        RepositoryProvider(
          create: (context) => PlanRepo(),
        ),
        RepositoryProvider(
          create: (context) => WalletRepo(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PlansCubit(repo: context.read<PlanRepo>())),
          BlocProvider(
              create: (context) =>
                  GradeCubit(repo: context.read<ProfileRepo>())),
          BlocProvider(
              create: (context) =>
                  RegistrationsCubit(repo: context.read<ProfileRepo>())),
          BlocProvider(
              create: (context) =>
                  DashboardCubit(repo: context.read<ProfileRepo>())),
          BlocProvider(
            create: (context) => McqCubit(mcqRepo: context.read<McqRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                ProfileCubit(profileRepo: context.read<ProfileRepo>()),
          ),
          BlocProvider(
            create: (context) => PendingCubit(repo: context.read<McqRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                CompletedExamCubit(repo: context.read<McqRepo>()),
          ),
          BlocProvider(
            create: (context) => QPPendingCubit(repo: context.read<McqRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                QPCompletedExamCubit(repo: context.read<McqRepo>()),
          ),
          BlocProvider(
            create: (context) => SearchCubit(repo: context.read<McqRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                ReviewCubit(reviewRepo: context.read<ReviewRepo>()),
          ),
          BlocProvider(
            create: (context) => QpSubjectsCubit(repo: context.read<McqRepo>()),
          ),
          BlocProvider(create: (context) => SplashCubit()),
          BlocProvider(
            create: (context) => QpMcqCubit(repo: context.read<McqRepo>()),
          ),
          BlocProvider(
            create: (context) => NotificationCubit(
                notificationRepo: context.read<NotificationsRepo>()),
          ),
          BlocProvider(
            create: (context) => WalletCubit(repo: context.read<WalletRepo>()),
          )
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Study MCQ Kannada app',
          getPages: appRouting(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: appColors.brandDark),
            useMaterial3: true,
          ),
          initialRoute: widget.isUserLogin ? '/HomeScreen' : '/SignIn',
        ),
      ),
    );
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.toNamed('/Offline');
    }
  }
}

Future<bool> checkingUserLoginOrNot() async {
  await Future.delayed(const Duration(seconds: 1));
  final box = GetStorage();
  String? accessToken = box.read('token');
  if (accessToken != null) {
    headers!["authorization"] = "Bearer $accessToken";
    return true;
  } else {
    return false;
  }
}
