import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';

class MicWordsField extends StatelessWidget {
  const MicWordsField({
    super.key,
    required bool speechEnabled,
    required this.lastWords,
  }) : _speechEnabled = speechEnabled;

  final bool _speechEnabled;
  final String lastWords;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: _speechEnabled && lastWords.isEmpty
              ? [
                  TextSpan(
                      text: "Share how you're feeling!",
                      style: CustomTextStyles.titleLargeRegular())
                ]
              : lastWords.split(' ').map((word) {
                  bool isLast = word == lastWords.split(' ').last;
                  return TextSpan(
                    text: '$word ',
                    style: TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: 0,
                      fontFamily: "Monasans",
                      fontWeight: isLast ? FontWeight.w500 : FontWeight.normal,
                      fontSize: 24,
                    ),
                  );
                }).toList(),
        ),
      ),
    );
  }
}
