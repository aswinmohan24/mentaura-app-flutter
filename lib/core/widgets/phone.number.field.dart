import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField(
      {super.key,
      required this.phoneNumberController,
      this.hintText,
      this.onTap,
      this.isProfileEdit = false});

  final TextEditingController phoneNumberController;
  final VoidCallback? onTap;
  final bool isProfileEdit;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70.w,
          height: 40.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: Palette.lightGreyColor,
              width: 1,
            ),
            borderRadius: isProfileEdit
                ? BorderRadius.only(
                    topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
                : BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/country_india_flag.png"))),
                ),
                const SizedBox(width: 3),
                Text(
                  '+91',
                  style: TextStyle(
                      color: Palette.primaryTextColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        isProfileEdit ? const SizedBox() : const SizedBox(width: 8),
        Container(
          height: 40.h,
          width: isProfileEdit ? context.width() * .723 : context.width() * .70,
          decoration: BoxDecoration(
            border: isProfileEdit
                ? Border(
                    bottom: BorderSide(color: Palette.lightGreyColor, width: 1),
                    right: BorderSide(color: Palette.lightGreyColor, width: 1),
                    top: BorderSide(color: Palette.lightGreyColor, width: 1))
                : Border.all(
                    color: Palette.lightGreyColor,
                    width: 1,
                  ),
            borderRadius: isProfileEdit
                ? BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))
                : BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: phoneNumberController,
            onTap: onTap,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    TextStyle(color: Palette.kGreyColor, fontSize: 12.sp),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        )
      ],
    );
  }
}
