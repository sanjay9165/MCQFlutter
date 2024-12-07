import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_state.dart';
import 'package:mcq/core/models/student_model.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import 'package:mcq/widgets/custom_button.dart';

import '../../core/cubits/dashboard_cubit/dashboard_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getStudentDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.brandDark,
      body: Column(
        children: [
          appSpaces.spaceForHeight25,
          appSpaces.spaceForHeight25,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'My Profile',
                  style: appFonts.f20w700White,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/EditProfile',
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                appSpaces.spaceForWidth10,
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/Notification');
                  },
                  child: const Badge(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
          appSpaces.spaceForHeight25,
          appSpaces.spaceForHeight10,
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: BlocConsumer<ProfileCubit, ProfileState>(
                          listener: (context, state) {},
                          buildWhen: (previous, current) =>
                              current is ProfileFetchState,
                          builder: (context, state) {
                            if (state is ProfileErrorState) {
                              return const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text('Something wrong'),
                                  ));
                            } else if (state is ProfileLoadingState) {
                              return const SizedBox(
                                  height: 100,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            } else if (state is ProfileSuccessState) {
                              StudentModel student = state.studentModel;

                              return Column(
                                children: [
                                  appSpaces.spaceForHeight10,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 81,
                                            width: 81,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 5.0,
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        student.gender == 'male'
                                                            ? appImages
                                                                .defaultAvatar
                                                            : appImages
                                                                .femaleAvatar),
                                                    fit: BoxFit.fill)),
                                          ),
                                          appSpaces.spaceForHeight10,
                                          Text(
                                            student.name ?? '',
                                            style: appFonts.f20w600Black,
                                          ),
                                          appSpaces.spaceForHeight10,
                                          Text(student.email ?? '',
                                              style: appFonts.f15w600Grey)
                                        ],
                                      )
                                    ],
                                  ),
                                  appSpaces.spaceForHeight20,
                                  BlocBuilder<DashboardCubit, DashboardState>(
                                      builder: (context, state) {
                                    if (state is DashboardLoaded) {
                                      return Container(
                                        height: 98,
                                        width: screenWidth(context) - 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.7, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children:
                                                  List.generate(5, (index) {
                                                List<String> titles = [
                                                  'Grade',
                                                  '',
                                                  'Avg Score',
                                                  '',
                                                  'Subjects'
                                                ];
                                                int? subjects = state
                                                    .data.allChapters?.length;
                                                double avgScore =
                                                    state.data.averageScore !=
                                                            null
                                                        ? double.parse(state
                                                                .data
                                                                .averageScore
                                                                .toString())
                                                            .truncateToDouble()
                                                        : 0;
                                                List<String> values = [
                                                  student.gradeId.toString(),
                                                  '',
                                                  avgScore.toString(),
                                                  '',
                                                  subjects != null
                                                      ? subjects.toString()
                                                      : '0'
                                                ];
                                                return index % 2 == 0
                                                    ? Column(
                                                        children: [
                                                          Text(
                                                            values[index],
                                                            style: appFonts
                                                                .f20w600Black,
                                                          ),
                                                          appSpaces
                                                              .spaceForHeight10,
                                                          Text(
                                                            titles[index],
                                                            style: appFonts
                                                                .f15w600Grey,
                                                          )
                                                        ],
                                                      )
                                                    : const ColoredBox(
                                                        color: Colors.grey,
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 0.8,
                                                        ),
                                                      );
                                              }),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                                  appSpaces.spaceForHeight20,
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          })),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),
                        ],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            List<String> titles = [
                              'Subscription',
                              'Invite Friends',
                              'Wallet Balance',
                              'Terms and Condition',
                              'Privacy Policy',
                              'Logout'
                            ];
                            List<Color> bgColors = const [
                              Color(0xFFE2FFFC),
                              Color(0xFFFFF6E8),
                              Color(0xffddf1fa),
                              Color(0xFFF6F1CA),
                              Color(0xFFD6F6CA),
                              Color(0xFFFFF5F5),
                            ];
                            List<dynamic> leadingIcons = [
                              appImages.checkbox,
                              appImages.gift,
                              Icons.wallet,
                              Icons.privacy_tip_outlined,
                              Icons.security,
                              appImages.power
                            ];
                            List<Color> iconsColor = [
                              Colors.blue.withOpacity(0.9),
                              const Color(0xFFD38C07),
                              const Color(0xFF409B21),
                            ];
                            List<IconData> icons = [
                              Icons.wallet,
                              Icons.privacy_tip_outlined
                            ];
                            return ListTile(
                              onTap: () {
                                if (index == 0) {
                                  Get.toNamed('/Subscription');
                                }

                                if (index == 1) {
                                  Get.toNamed('/Invite');
                                }
                                if (index == 2) {
                                  Get.toNamed('/WalletBalance');
                                }
                                if (index == 3) {
                                  Get.toNamed('/TermsAndCondition');
                                }
                                if (index == 4) {
                                  Get.toNamed('/PrivacyPolicyScreen');
                                }
                                if (index == 5) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: SizedBox(
                                        height: 300,
                                        width: screenWidth(context) < 400
                                            ? double.infinity
                                            : 380,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.info_outline,
                                                size: 90,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                'Are you sure to logout from MCQ',
                                                textAlign: TextAlign.center,
                                                style: appFonts.f21w1000Black,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: CustomButton(
                                                      title: 'No',
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                  ),
                                                  appSpaces.spaceForWidth20,
                                                  Expanded(
                                                    flex: 1,
                                                    child: CustomButton(
                                                      title: 'Yes',
                                                      onTap: () async {
                                                        final box =
                                                            GetStorage();
                                                        await box
                                                            .remove('token');
                                                        box.erase();
                                                        Get.offAllNamed(
                                                            '/SignIn');
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: bgColors[index]),
                                child: Center(
                                  child:
                                      leadingIcons[index].runtimeType == String
                                          ? Image.asset(
                                              leadingIcons[index],
                                              height: 20,
                                            )
                                          : Icon(leadingIcons[index],
                                              color: iconsColor[index - 2]),
                                ),
                              ),
                              title: Text(titles[index]),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                          itemCount: 6),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
