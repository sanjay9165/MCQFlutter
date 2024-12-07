import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcq/core/cubits/plans_cubit/plans_cubit.dart';
import 'package:mcq/core/models/payment_details.dart';

class PaymentLoadingScreen extends StatefulWidget {
  const PaymentLoadingScreen({super.key, required this.paymentDetails, required this.planId});

  final PaymentDetails paymentDetails;
  final String planId;

  @override
  State<PaymentLoadingScreen> createState() => _PaymentLoadingScreenState();
}

class _PaymentLoadingScreenState extends State<PaymentLoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PlansCubit>(context).paymentStarting(paymentDetails: widget.paymentDetails, planId: widget.planId,referralCode: '');
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SafeArea(child:
        CircularProgressIndicator(),),
      // body: BlocConsumer<PlansCubit, PlansState>(
      //   listener: (context, state) {
      //   // if(state is PlanTransactionSuccessState){
      //   //   Get.offAllNamed('/');
      //   // }
      //   },
      //   builder: (context, state) {
      //     if(state is PlanTransactionLoadingState) {
      //       return Center(child:const CircularProgressIndicator(),);
      //     }else if(state is PlanTransactionSuccessState){
      //       return Center(child:Icon(Icons.check_circle,size: 50,color: Colors.green,),);
      //     }else{
      //       return Center(child: Icon(Icons.error,size: 50,color: Colors.red.withOpacity(0.7),),);
      //     }
      //   },
      // ),
    );
  }
}
