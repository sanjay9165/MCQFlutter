import 'package:bloc/bloc.dart';
import 'package:mcq/core/cubits/wallet_cubit/wallet_state.dart';
import 'package:mcq/core/repositories/wallet_repo.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepo repo;

  WalletCubit({required this.repo}) :super(WalletInitialState());

  Future<void> getWalletDetails() async {
    emit(WalletFetchLoadingState());
    final isSuccess = await repo.getWalletDetails();
    if (isSuccess.isRight) {
      emit(WalletFetchSuccessState(walletDetails: isSuccess.right));
    } else {
      emit(WalletFetchErrorState(error: isSuccess.left));
    }
  }

  Future<void> claimWalletAmount({required String amount}) async {
    emit(ClaimAmountLoadingState());
    String? isError = await repo.claimWalletAmount(amount: amount);
    if (isError == null) {
      emit(ClaimAmountSuccessState());
    } else {
      emit(ClaimAmountErrorState(error: isError));
    }
  }


}
