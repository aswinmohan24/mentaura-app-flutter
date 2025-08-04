import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HiddenTextFieldOnKBoard extends StatelessWidget {
  final VoidCallback onTap;
  const HiddenTextFieldOnKBoard({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(27),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 39.h,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: TextField(
            showCursor: false,
            style: TextStyle(color: Colors.transparent),
            onTap: onTap,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
