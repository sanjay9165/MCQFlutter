
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_state.dart';
import 'package:mcq/core/cubits/wallet_cubit/wallet_cubit.dart';
import 'package:mcq/core/cubits/wallet_cubit/wallet_state.dart';
import 'package:mcq/core/models/bank_details_model.dart';
import 'package:mcq/core/models/wallet_model.dart';
import 'package:mcq/manager/color_manager.dart';
import 'package:mcq/manager/font_manager.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_scaffold.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import 'package:mcq/widgets/custom_textField.dart';
import 'package:mcq/widgets/wallet_balance/show_bank_details.dart';
import 'package:mcq/widgets/loading_button.dart';
import '../../widgets/wallet_balance/add_bank_details.dart';


class WalletBalanceScreen extends StatefulWidget {
  const WalletBalanceScreen({super.key});

  @override
  State<WalletBalanceScreen> createState() => _WalletBalanceScreenState();
}

class _WalletBalanceScreenState extends State<WalletBalanceScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  bool isBankDetails = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WalletCubit>(context).getWalletDetails();
    BlocProvider.of<ProfileCubit>(context).fetchUserBankDetails();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer<WalletCubit, WalletState>(
          buildWhen: (previous, current) => current is WalletFetchState,
          listener: (context, state) {
            if (state is WalletFetchErrorState) {
              customSnackBar(title: 'Error', message: state.error);
            }
          },
          builder: (context, state) {
            if (state is WalletFetchSuccessState) {
              WalletModel walletDetails = state.walletDetails;
              return Align(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(

                        walletDetails.balance.toString(),
                        style: TextStyle(fontSize: 90, color: appColors.brandDark, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Wallet Balance',
                        style: appFonts.f21w1000Black,
                      ),
                      appSpaces.spaceForHeight20,
                      Form(
                        key: _formKey,
                        child: CustomTextField(
                          controller: amountController,
                          label: 'Amount to Claim',
                          isNumberOnly: true,
                          validator: (amount) {
                            if (amount == null || amount == '') {
                              return 'Please enter amount';
                            }

                            int? value = int.tryParse(amount);
                            if (value == null || value <= 0) {
                              return 'Please enter valid amount';
                            } else if (value > int.parse(walletDetails.balance.toString())) {
                              return 'Amount should be greater or equal with your wallet amount';
                            } else if (value < int.parse(walletDetails.minAmount!)) {
                              return 'Amount should be greater or equal to ${walletDetails.minAmount}';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      appSpaces.spaceForHeight20,
                      BlocBuilder<ProfileCubit, ProfileState>(
                        buildWhen: (previous, current) => current is BankDetailsFetchState,
                        builder: (context, state) {
                          if (state is BankDetailsFetchSuccessState) {
                            BankDetailsModel? bankDetails = state.bankDetails;
                            isBankDetails = bankDetails != null;
                            return bankDetails != null
                                ?
                                /// SHOWING BANK DETAILS
                                BankDetailsContainer(bankDetails: bankDetails)
                                /// SHOWING WIDGET FOR ADD BANK DETAILS
                                : const AddBankDetailsContainer();
                          } else if (state is BankDetailsFetchLoadingState) {
                            return ColoredBox(
                              color: appColors.brandLite,
                              child: const SizedBox(
                                height: 110,
                                width: double.infinity,
                              ),
                            );
                          } else {
                            return SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Can,t fetch bank details',
                                    style: appFonts.f14w600BrandDark,
                                  ),
                                ));
                          }
                        },
                      ),
                      appSpaces.spaceForHeight25,
                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                              ),
                              appSpaces.spaceForWidth10,
                              Expanded(
                                  child: Text(
                                      'The minimum amount to claim is ${walletDetails.minAmount}, and you can earn more amount through invite'))
                            ],
                          ),
                          BlocConsumer<WalletCubit, WalletState>(
                            listener: (context, state) {
                              if (state is ClaimAmountErrorState) {
                                customSnackBar(title: 'Error', message: state.error, isError: true);
                              } else if (state is ClaimAmountSuccessState) {
                                BlocProvider.of<WalletCubit>(context).getWalletDetails();
                                amountController.clear();
                                customSnackBar(title: 'Success', message: 'Claim request success');
                              }
                            },
                            builder: (context, state) {
                              return state is! ClaimAmountLoadingState
                                  ? CustomButton(
                                      title: 'Claim',
                                      onTap: () {
                                        if (_formKey.currentState!.validate() && isBankDetails) {
                                          return BlocProvider.of<WalletCubit>(context)
                                              .claimWalletAmount(amount: amountController.text);
                                        } else if (!isBankDetails) {
                                          customSnackBar(
                                              title: 'Bank details empty',
                                              message: 'Please add Bank details to claim balance');
                                        }
                                      },
                                    )
                                  : const LoadingButton();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
              // b81c999
            } else if (state is WalletFetchErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: appFonts.f16w600Black.copyWith(color: Colors.red.withOpacity(0.7)),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      headerIcon: const Icon(
        Icons.wallet,
        size: 40,
        color: Colors.blue,
      ),
      headerTitle: 'Wallet Balance',
      headerIconBg: const Color(0xffddf1fa),
    );
  }
}
