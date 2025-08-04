import 'package:flutter/material.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color? color;
  final Color? textColor;
  final double leftpadding;
  final double rightpadding;
  final TextStyle? txtStyle;
  final double? height;
  final String? svgImage;
  final bool isInvertColor;

  const DefaultButton(
      {super.key,
      required this.text,
      required this.press,
      this.isInvertColor = false,
      this.txtStyle,
      this.height = 50,
      this.leftpadding = 20,
      this.rightpadding = 20,
      this.color,
      this.textColor = Colors.white,
      this.svgImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: isInvertColor
                  ? BorderSide(color: Palette.kPrimaryGreenColor)
                  : BorderSide.none),
          backgroundColor: color ?? Palette.kPrimaryGreenColor,
        ),
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              overflow: TextOverflow.fade,
              style: txtStyle ??
                  TextStyle(
                      fontSize: 14,
                      // fontVariations: const [FontVariation("wght", 350)],
                      color: isInvertColor
                          ? Palette.kPrimaryGreenColor
                          : Palette.kWhiteColor,
                      letterSpacing: -0.2),
            ),
          ],
        ),
      ),
    );
  }
}
