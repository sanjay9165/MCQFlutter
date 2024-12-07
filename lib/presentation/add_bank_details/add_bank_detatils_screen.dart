import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:mcq/core/cubits/profile_cubit/profile_state.dart';
import 'package:mcq/core/models/bank_details_model.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/widgets/custom_button.dart';
import 'package:mcq/widgets/custom_snackBar.dart';
import 'package:mcq/widgets/custom_textField.dart';
import 'package:mcq/widgets/loading_button.dart';

import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';


class AddBankDetailsScreen extends StatefulWidget {
  const AddBankDetailsScreen({super.key, required this.isEdit, this.bankDetails});
final bool isEdit;
final BankDetailsModel? bankDetails;
  @override
  State<AddBankDetailsScreen> createState() => _AddBankDetailsScreenState();
}

class _AddBankDetailsScreenState extends State<AddBankDetailsScreen> {
  TextEditingController numberController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  final _formKey=GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.bankDetails!=null){
      numberController.text=widget.bankDetails!.accountNumber.toString();
      holderNameController.text=widget.bankDetails!.holderName.toString();
      ifscCodeController.text=widget.bankDetails!.ifscCode.toString();
      upiIdController.text=widget.bankDetails!.upiId.toString();
      bankNameController.text=widget.bankDetails!.bankName.toString();
    }
  }
  @override
  void dispose() {
    numberController.dispose();
    holderNameController.dispose();
    ifscCodeController.dispose();
    upiIdController.dispose();
    bankNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.brandDark,
        title: Text(
         "${widget.isEdit?"Edit":"Add"} Bank Details",
          style: appFonts.f16w600White,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                ...List.generate(5, (index) {
                  List<String> labels = ['Account number', 'Bank holder name', 'Ifsc code', 'Upi id', 'Bank name'];
                 List<TextEditingController>controllers=[numberController,holderNameController,ifscCodeController,upiIdController,bankNameController];
                  return CustomTextField(
                    controller: controllers[index],
                    isNumberOnly: index==0,
                      label: labels[index], validator: (value) {
                       if(value==null||value==''){
                         return 'Please Enter ${labels[index]}';
                       }
                       if(index==0) {
                         BigInt? number = BigInt.tryParse(value.trim());
                         if(number==null){
                           return "Please Enter a valid number";
                         }
                       }
                       return null;
                  });
                }),
                appSpaces.spaceForHeight25,
                BlocConsumer<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) => current is AddBankDetailsState,
                  listener: (context, state) {
                  if(state is AddBankDetailsSuccessState){
                    BlocProvider.of<ProfileCubit>(context).fetchUserBankDetails();
                    Get.back();
                    customSnackBar(title: 'Success', message: 'Bank details successfully ${widget.isEdit?'updated':'added'}');

                  }else if(state is AddBankDetailsErrorState){
                    customSnackBar(title: 'Error', message: state.error,isError: true);
                  }
                  },
                  builder: (context, state) {
                    return state is !AddBankDetailsLoadingState? CustomButton(height: 45, title: '${widget.isEdit?'Edit':'Add'} details', onTap: () {
                      if(_formKey.currentState!.validate()) {
                        Map<String, dynamic>details = {
                          "account_number": numberController.text.trim(),
                          "holder_name": holderNameController.text.trim(),
                          "ifsc_code": ifscCodeController.text.trim(),
                          "upi_id": upiIdController.text.trim(),
                          "bank_name": bankNameController.text.trim()
                        };
                        BlocProvider.of<ProfileCubit>(context).addOrEditBankDetails(details: details);
                      }

                    },):const LoadingButton(height: 45,width: double.infinity,);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
