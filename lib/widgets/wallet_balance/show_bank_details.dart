import 'package:flutter/material.dart';
import 'package:mcq/core/models/bank_details_model.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';
import 'add_edit_bank_details.dart';

class BankDetailsContainer extends StatelessWidget {
  const BankDetailsContainer({super.key, required this.bankDetails});
  final BankDetailsModel bankDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: appColors.brandLite,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: appColors.brandDark)),
          child: Column(
            children: List.generate(2, (index) {
              List<String> titles = [
                'Upi id',
                'Holder Name',
                'ifsc Code',
                'Account Number',
                'Holder Name',
                'Bank name'
              ];
              List<String> values = [
                bankDetails.upiId.toString(),
                bankDetails.holderName.toString(),
                bankDetails.accountNumber.toString(),
                bankDetails.ifscCode.toString(),
                bankDetails.bankName.toString()
              ];
              return Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        titles[index],
                        style: appFonts.f14w400Grey.copyWith(color: Colors.black),
                      )),
                  Expanded(
                      flex: 1,
                      child: Center(
                          child: Text(
                        ':',
                        style: appFonts.f14w600Black,
                      ))),
                  Expanded(
                      flex: 1,
                      child: Text(
                        values[index],
                        style: appFonts.f14w600Black,
                      ))
                ],
              );
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ColoredBox(
              color: appColors.brandDark,
              child: SizedBox(
                height: 20,
                width: 20,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => UpiAddAndEditAlert(
                        bankDetails: bankDetails,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
