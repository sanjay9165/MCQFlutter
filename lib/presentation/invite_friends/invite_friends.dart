import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcq/core/cubits/plans_cubit/plans_cubit.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_scaffold.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PlansCubit>(context).fetchInviteCode();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        content: BlocConsumer<PlansCubit,PlansState>(
          buildWhen: (previous, current) => current is FetchInviteCodeState,
          listener: (context, state) {
         if(state is FetchInviteCodeErrorState){
           customSnackBar(title: 'Error', message: state.error);
         }
          },
          builder: (context, state) {
           if(state is FetchInviteCodeSuccessState) {
             Map inviteDetails=state.inviteCodeDetails;
             return Column(
               children: [
                 const SizedBox(
                   height: 85,
                 ),
                 SizedBox(
                   width: screenWidth(context) * 0.60,
                   child: Text(
                     'Invite Friends Get ${inviteDetails['signup_bonus']} Coins',
                     textAlign: TextAlign.center,
                     style: appFonts.f19w600Black.copyWith(color: appColors.brandDark),
                   ),
                 ),
                 appSpaces.spaceForHeight25,
                 SizedBox(
                   width: screenWidth(context) * 0.65,
                   child: Text('When your friend subscribe with your referral code, you’ll get ${inviteDetails['signup_bonus']} Coins',
                       textAlign: TextAlign.center, style: appFonts.f18w500Black),
                 ),
                 const SizedBox(
                   height: 35,
                 ),
                 Column(
                   children: [
                     Row(
                       children: [
                         Text('Share Your Invite Code', style: appFonts.f17w600Black),
                       ],
                     ),
                     appSpaces.spaceForHeight10,
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                       height: 45,
                       width: screenWidth(context) - 20,
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black, width: 0.7),
                           color: const Color.fromARGB(0, 168, 31, 31),
                           borderRadius: BorderRadius.circular(5)),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             state.inviteCodeDetails['invite_code'],
                             style: appFonts.f16w600Black,
                           ),
                           GestureDetector(
                               onTap: () async {
                                 await Clipboard.setData(ClipboardData(text: state.inviteCodeDetails['invite_code']));
                                 customSnackBar(title: 'Copied', message: 'Invite code copied');
                               },
                               child: const Icon(
                                 Icons.copy,
                                 color: Colors.black,
                               ))
                         ],
                       ),
                     ),
                     appSpaces.spaceForHeight20,
                     Text('You can only refer ${inviteDetails['limit']} friends',style: appFonts.f14w600Black,)
                   ],
                 ) ,
                 const Spacer(),
                 CustomButton(
                   title: 'Invite Friends',
                   onTap: () {
                     Share.share('Install MCQ app from play store https://play.google.com/store/apps/details?id=com.mcq.mcq\nUse this referral code ${state.inviteCodeDetails['invite_code']}',);
                   },
                 ),
                 appSpaces.spaceForHeight20,
               ],
             );
           }else{
             return const Center(
               child: SizedBox(
                 height: 30,
                   width: 30,
                   child: CircularProgressIndicator()),
             );
           }
          }
        ),
        headerImage: appImages.gift,
        headerTitle: 'Invite Friends',
        headerIconBg: const Color(0xFFFFF6E8));
  }
}
