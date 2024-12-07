import 'package:flutter/material.dart';
import 'package:mcq/manager/font_manager.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool? isPassWord;
  final bool? isNumberOnly;
  final bool? isReadOnly;
  final String? Function(String?) validator;
  final String? Function(String?)? onChange;
  final TextEditingController? controller;
  final int? maxLength;
  final TextStyle? textStyle;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Widget? suffixWidget;
  const CustomTextField(
      {super.key,
      this.onChange,
      required this.label,
      this.isPassWord,
      required this.validator,
      this.controller,
      this.isNumberOnly,
      this.maxLength,
      this.isReadOnly,
      this.onTap,
      this.textStyle,
      this.focusNode,
      this.suffixWidget});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          onChanged: widget.onChange,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          style: widget.textStyle ??
              appFonts.f18w500Black.copyWith(
                  color: widget.isReadOnly != null && widget.isReadOnly!
                      ? Colors.grey
                      : Colors.black),
          readOnly: widget.isReadOnly ?? false,
          controller: widget.controller,
          maxLength: widget.maxLength,
          obscureText: widget.isPassWord ?? false ? !showText : false,
          keyboardType:
              widget.isNumberOnly ?? false ? TextInputType.number : null,
          decoration: InputDecoration(
            suffix: widget.suffixWidget,
            label: Text(
              widget.label,
              style: appFonts.f14w400Grey,
            ),
            suffixIcon: widget.isPassWord ?? false
                ? showText
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showText = !showText;
                          });
                        },
                        icon: const Icon(
                          Icons.hide_source,
                          color: Colors.grey,
                        ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            showText = !showText;
                          });
                        },
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ))
                : null,
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
