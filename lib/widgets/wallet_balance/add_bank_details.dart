
import 'package:flutter/material.dart';
import '../../manager/color_manager.dart';
import '../../manager/font_manager.dart';
import '../../manager/space_manager.dart';
import 'add_edit_bank_details.dart';


class AddBankDetailsContainer extends StatelessWidget {
  const AddBankDetailsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: appColors.brandLite, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(
            'Bank details is empty, please add details to claim your balance',
            textAlign: TextAlign.center,
            style: appFonts.f14w600Black,
          ),
          appSpaces.spaceForHeight10,
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const UpiAddAndEditAlert(),
              );
            },
            child: Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                  color: appColors.brandDark, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'Add details',
                  style: appFonts.f14w400White,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}