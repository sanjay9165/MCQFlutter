import 'package:mcq/core/models/wallet_model.dart';

abstract class WalletState {

}
class WalletInitialState extends WalletState{}

/// THIS STATES FOR FETCHING WALLET DETAILS

class WalletFetchState extends WalletState{}

class WalletFetchSuccessState extends WalletFetchState{
  final WalletModel walletDetails;

  WalletFetchSuccessState({required this.walletDetails});
}
class WalletFetchErrorState extends WalletFetchState{
  final String error;

  WalletFetchErrorState({required this.error});
}

class WalletFetchLoadingState extends WalletFetchState{

}

/// THIS STATES FOR CLAIM AMOUNT FROM WALLET
class ClaimAmountState extends WalletState{}

class ClaimAmountSuccessState extends ClaimAmountState{

}
class ClaimAmountErrorState extends ClaimAmountState{
  final String error;

  ClaimAmountErrorState({required this.error});}

class ClaimAmountLoadingState extends ClaimAmountState{

}
