
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../core/cubits/profile_cubit/profile_cubit.dart';
import '../../core/cubits/profile_cubit/profile_state.dart';
import '../../core/models/bank_details_model.dart';
import '../../manager/font_manager.dart';
import '../custom_button.dart';
import '../custom_snackBar.dart';
import '../custom_textField.dart';
import '../loading_button.dart';

class UpiAddAndEditAlert extends StatefulWidget {
  const UpiAddAndEditAlert({
    super.key,
    this.bankDetails,
  });
  final BankDetailsModel? bankDetails;

  @override
  State<UpiAddAndEditAlert> createState() => _UpiAddAndEditAlertState();
}

class _UpiAddAndEditAlertState extends State<UpiAddAndEditAlert> {
  TextEditingController upiIdController = TextEditingController();
  TextEditingController holderNameController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {

    super.initState();
    if(widget.bankDetails!=null) {
      upiIdController.text = widget.bankDetails!.upiId.toString();
      holderNameController.text=widget.bankDetails!.holderName.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.bankDetails != null;
    return AlertDialog(

      title: Text('${isEdit ? 'Edit' : 'Add'} Upi Id'),
      titleTextStyle: appFonts.f16w600,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(2, (index) {
            List<String>labels=['UpiId','Holder name'];
            List<TextEditingController>controllers=[upiIdController,holderNameController];
            return CustomTextField(
              controller: controllers[index],
              label: labels[index],
              validator: (value) {
                if (value == null || value == '') {
                  return 'Please enter ${labels[index]}';
                }else {
                  return null;
                }
              },
            );

          },
          ),
        ),
      ),
      actions: [
        BlocConsumer<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) => current is AddBankDetailsState,
          listener: (context, state) {
            if (state is AddBankDetailsSuccessState) {
              BlocProvider.of<ProfileCubit>(context).fetchUserBankDetails();
              Get.back();
              customSnackBar(title: 'Success', message: 'Bank details successfully ${isEdit ? 'updated' : 'added'}');
            } else if (state is AddBankDetailsErrorState) {
              customSnackBar(title: 'Error', message: state.error, isError: true);
            }
          },
          builder: (context, state) {
            return state is! AddBankDetailsLoadingState
                ? CustomButton(
              title: '${isEdit ? 'Edit' : 'Add'} Details',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<ProfileCubit>(context).addOrEditBankDetails(details: {
                    "upi_id": upiIdController.text.trim(),
                    "holder_name":holderNameController.text.trim(),
                  });
                }
              },
            )
                : const LoadingButton(
              height: 45,
              width: double.infinity,
            );
          },
        )
      ],
    );
  }
}