import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcq/core/cubits/plans_cubit/plans_cubit.dart';
import 'package:mcq/core/models/plan_models.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/widgets/custom_appBar.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import '../../widgets/select_plan_widgets/custom_select.dart';


class SelectPlanScreen extends StatefulWidget {
  const SelectPlanScreen({super.key});

  @override
  State<SelectPlanScreen> createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  String selectedPlan = "";
  final String paidPrice = "₹799";
  final String mrp = "₹999";
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PlansCubit>(context).getPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PlansCubit, PlansState>(
        listener: (context, state) {
          if (state is PlansError) {
            customSnackBar(title: 'Error', message: state.error);
          }
        },
        builder: (context, state) {
          PlanModel freeModel = PlanModel();
          PlanModel paidModel = PlanModel();
          if (state is PlansLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  const CustomAppBar(title: "Choose Your Plan"),
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
                            // selectedPlan = "free";
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
                                                decorationColor: Colors.white),
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
                  // InkWell(
                  //   onTap: (){
                  //     setState(() {
                  //       selectedPlan = "paid";
                  //     });
                  //   },
                  //   child: Stack(
                  //     children: [
                  //       SizedBox(
                  //         width: 320,
                  //         height: 110,
                  //         child: Center(
                  //           child: AnimatedContainer(
                  //             duration: const Duration(
                  //                 milliseconds: 200
                  //             ),
                  //             height: 110,
                  //             width: selectedPlan == "paid" ? 290 : 320,
                  //             padding: const EdgeInsets.all(10),
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(5),
                  //                 color: Colors.white,
                  //                 border: Border.all(
                  //                     color: appColors.brandDark
                  //                 )
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                   width: 190,
                  //                   child: Column(
                  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(paidModel.title.toString(),style: appFonts.f16w700White.copyWith(
                  //                           color: appColors.brandDark
                  //                       ),),
                  //                       Text(paidModel.subTitle.toString(),
                  //                         style: appFonts.f14w400White.copyWith(
                  //                             color: appColors.brandDark
                  //                         ),),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Column(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     Text("₹${paidModel.price}",
                  //                       style: appFonts.f14w400White.copyWith(
                  //                           decoration: TextDecoration.lineThrough,
                  //                           decorationColor: appColors.brandDark,
                  //                           color: appColors.brandDark
                  //                       ),),
                  //                     Text("₹${paidModel.discountedPrice}",
                  //                       style: appFonts.f20w700White.copyWith(
                  //                           color: appColors.brandDark
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       selectedPlan == "paid" ?
                  //       const CustomSelect() :
                  //       const SizedBox()
                  //     ],
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                    child: SearchBar(
                      elevation: WidgetStateProperty.all(0),
                      hintText: "Enter referral code if any",
                      hintStyle: WidgetStateProperty.all(appFonts.f12w400Grey),
                      backgroundColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.2)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomButton(
          title: 'Continue',
          onTap: () {

          },
        ),
      ),
    );
  }
}
