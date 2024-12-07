
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mcq/config/controllers/subscription_controller.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_scaffold.dart';
import 'package:mcq/widgets/select_plan_widgets/custom_select.dart';
import '../../core/cubits/plans_cubit/plans_cubit.dart';
import '../../core/models/plan_models.dart';
import '../../widgets/custom_snackBar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  SubscriptionController subscriptionController = Get.put(SubscriptionController());
  String selectedPlan = "";
  final String paidPrice = "₹799";
  final String mrp = "₹999";
  int currentIndex = 0;
  String planId = '';
  bool isSelectedPlanIsFree = false;
  bool? isReferralValid;
  TextEditingController referralController = TextEditingController();
  @override
  void initState() {

    super.initState();
    BlocProvider.of<PlansCubit>(context).getPlans();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      headerTitle: 'Subscription',
      headerIconBg: const Color(0xFFE2FFFC),
      headerImage: appImages.checkbox,
      content: BlocConsumer<PlansCubit, PlansState>(
        buildWhen: (previous, current) => current is PlansFetchState,
        listener: (context, state) {
          if (state is PlansError) {
            customSnackBar(title: 'Error', message: state.error);
          }
        },
        builder: (context, state) {
          if (state is PlansLoaded) {
            planId = state.planDetails.plans![currentIndex].id!.toString();
            isSelectedPlanIsFree = state.planDetails.plans![currentIndex].isFree == 1;
            DateTime? expiryData=DateTime.tryParse(state.planDetails.expiryDate??state.planDetails.expiryDay??'');
           bool isPlanExpired=expiryData==null||expiryData.isBefore(DateTime.now());
            return SafeArea(
              child: SingleChildScrollView(
                child: isPlanExpired? Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                   ...List.generate(state.planDetails.plans!.length, (index) {
                      PlanModel plan = state.planDetails.plans![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 320,
                                height: 110,
                                child: Center(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    height: 110,
                                    width: currentIndex == index ? 290 : 320,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        border: currentIndex != index ? Border.all(color: appColors.brandDark) : null,
                                        gradient: currentIndex == index
                                            ? LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.bottomRight,
                                                colors: [appColors.brandDark, appColors.brandDark.withOpacity(0.5)])
                                            : null),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 190,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                plan.title.toString(),
                                                style: appFonts.f16w700White.copyWith(
                                                    color: currentIndex == index ? Colors.white : appColors.brandDark),
                                              ),
                                              Text(
                                                plan.subTitle.toString(),
                                                style: appFonts.f14w400White.copyWith(
                                                    color: currentIndex == index ? Colors.white : appColors.brandDark),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "₹${plan.price}",
                                              style: appFonts.f14w400White.copyWith(
                                                  color: currentIndex == index ? Colors.white : appColors.brandDark,
                                                  decoration: TextDecoration.lineThrough,
                                                  decorationThickness: 3,
                                                  decorationColor:currentIndex==index? Colors.white:appColors.brandDark),
                                            ),
                                            Text(
                                              plan.isFree == 1 ? "Free" : plan.discountedPrice.toString(),
                                              style: appFonts.f20w700White.copyWith(
                                                  color: currentIndex == index ? Colors.white : appColors.brandDark),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              currentIndex == index ? const CustomSelect() : const SizedBox()
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    !isSelectedPlanIsFree
                        ? BlocConsumer<PlansCubit, PlansState>(
                            buildWhen: (previous, current) => current is ReferralCodeCheckState,
                            listener: (context, state) {
                              if (state is ReferralCodeCheckErrorState) {
                                 customSnackBar(title: 'Error', message: state.error,isError: true);
                                 isReferralValid=false;
                              }
                            },
                            builder: (context, state) {
                              if (state is ReferralCodeCheckSuccessState) {
                                isReferralValid = state.isValid;
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SearchBar(
                                      textStyle: WidgetStateProperty.all(appFonts.f16w600Black),
                                      elevation: WidgetStateProperty.all(0),
                                      hintText: "Enter referral code if any",
                                      controller: referralController,
                                      trailing: [
                                        state is ReferralCodeCheckLoadingState?const CircularProgressIndicator():const SizedBox()
                                      ],
                                      onChanged: (value)async {
                                        if(value.length>4) {
                                          if(state is !ReferralCodeCheckLoadingState) {
                                            await Future.delayed(const Duration(seconds: 1));
                                            BlocProvider.of<PlansCubit>(context).checkReferralCodeIsValid(
                                                referralCode: value);
                                          }
                                        }
                                      },
                                      onSubmitted: (value) {
                                        BlocProvider.of<PlansCubit>(context).checkReferralCodeIsValid(referralCode: value);
                                      },
                                      side:WidgetStateProperty.all(BorderSide(color: isReferralValid==null?Colors.white:isReferralValid!?Colors.green:Colors.red)),
                                      hintStyle: WidgetStateProperty.all(appFonts.f12w400Grey),
                                      backgroundColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.2)),

                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                    ),
                                    const SizedBox(height: 6,),
                                    isReferralValid!=null?Text(
                              isReferralValid!?'The invite code is valid':'The invite code is invalid',style: appFonts.f15w600Grey.copyWith(color: isReferralValid!?Colors.green:Colors.red.withOpacity(0.7)),
                              ):const SizedBox()
                                  ],
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: screenHeight(context) * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: BlocConsumer<PlansCubit, PlansState>(
                        buildWhen: (previous, current) => current is PlanInitiateState,
                        listener: (context, state) {
                          if (state is PlanInitiationSuccessState) {
                            BlocProvider.of<PlansCubit>(context).paymentStarting(
                                paymentDetails: state.paymentDetails,
                                planId: planId,
                                referralCode: isReferralValid!=null&&isReferralValid! ? referralController.text : null);
                          } else if (state is PlanInitiationErrorState) {
                            customSnackBar(title: 'Error', message: state.error, isError: true);
                          }else if(state is PlanTransactionSuccessState){

                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            title: 'Continue',
                            onTap: () async {
                              if(!isSelectedPlanIsFree) {
                                BlocProvider.of<PlansCubit>(context).initiatePayment(planId: planId);
                              }else{
                                customSnackBar(title: 'Already Subscribed', message: 'This plan is already subscribed by default');
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                ):Column(

                  children: [
                     SizedBox(height: screenHeight(context)*0.30),
                  Text('You already subscribed !',style: appFonts.f20w600Black,),
                    Text('You have a plan until ${expiryData.toString().split(' ').first}',style: appFonts.f16w600Black.copyWith(color: appColors.brandDark),)
                ],),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
