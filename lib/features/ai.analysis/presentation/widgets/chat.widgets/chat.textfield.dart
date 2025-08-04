import 'package:flutter/material.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required FocusNode emotionTextfieldFocus,
    required TextEditingController emotionTextController,
    required this.onchanged,
  })  : _emotionTextfieldFocus = emotionTextfieldFocus,
        _emotionTextController = emotionTextController;

  final FocusNode _emotionTextfieldFocus;
  final TextEditingController _emotionTextController;
  final Function(String)? onchanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
          height: context.width(),
          child: TextField(
            focusNode: _emotionTextfieldFocus,
            controller: _emotionTextController,
            onChanged: onchanged,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: "Type Something..",
                hintStyle: CustomTextStyles.titleLargeRegular(
                    color: Palette.lightGreyColor)),
            cursorColor: Palette.primaryBlackColor,
            maxLines: 10,
            style: CustomTextStyles.titleLargeRegular(),
          )),
    );
  }
}
