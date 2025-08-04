import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final VoidCallback onPressed;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
    super.key,
    this.validator,
    this.inputFormatters,
    required this.hintText,
    required this.onPressed,
    required this.controller,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      constraints: BoxConstraints(maxWidth: context.width() - 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.lightGreyColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onTap: onPressed,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Palette.kGreyColor, fontSize: 12.sp),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
