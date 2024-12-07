import 'package:flutter/material.dart';
import 'package:mcq/manager/space_manager.dart';
import 'package:mcq/utils/screen_dimensions.dart';

import '../../manager/font_manager.dart';




class MCQNonEditableCard extends StatefulWidget {
  final List<String> options;
  final  int correctAnsIndex;
  final String question;
  final String description;
  const MCQNonEditableCard({super.key,
    required this.correctAnsIndex, required this.options, required this.question, required this.description,
  });

  @override
  State<MCQNonEditableCard> createState() => _MCQNonEditableCardState();
}

class _MCQNonEditableCardState extends State<MCQNonEditableCard> {
  //List<TextEditingController> options = [];
  List<String> optionIndex =["A","B","C","D"];

  @override
  Widget build(BuildContext context) {

    return
      SizedBox(
        child: Column(
          children: [
            Container(
              width: getDimension(context: context,horizontalPadding: 15).w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.4)
              ),
              constraints: const BoxConstraints(
                  minHeight: 100
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    text: "Description: ",
                    style: appFonts.f14w800Black,
                    children: [
                      TextSpan(
                        text: widget.description,
                        style: appFonts.f12w600Black
                      )
                    ]
                  ),
                ),
              ),
            ),
            appSpaces.spaceForHeight10,
            Container(
              width: getDimension(context: context,horizontalPadding: 15).w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.4)
              ),
              constraints: const BoxConstraints(
                minHeight: 100
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.question,
                maxLines: 25,
                  style: appFonts.f12w600Black,),
              ),
            ),
            Column(
              children: List.generate(widget.options.length,
                      (index) {
                      return TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText:  widget.options[index],
                            prefixIcon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                ),
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none
                            )
                        ),
                      );


                  }
              ),
            ),

            const Divider(),
            Row(
              children: [
                Text("Right Answer",style: appFonts.f14w600Black,),
                const SizedBox(
                  width: 10,
                ),
                Row(
                    children:
                    List.generate(widget.options.length,
                          (index) =>  Chip(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8),
                            color:  widget.correctAnsIndex == index ?
                            WidgetStateProperty.all(
                                Colors.green) :
                            WidgetStateProperty.all(
                                Colors.grey.withOpacity(0.3)),
                            label:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(optionIndex[index],
                                style: widget.correctAnsIndex == index ?
                                appFonts.f14w600Black.copyWith(
                                    color: Colors.white
                                ) :
                                appFonts.f14w600Black,),
                            ),
                            shape: const CircleBorder(
                            ), side: BorderSide.none,
                          ),
                    )
                )
              ],
            )
          ],
        ),
      );
  }
}
