import 'package:flutter/material.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class DoneButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const DoneButtonWidget({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          backgroundColor: Palette.backgroundColor,
          radius: 31,
          child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.done,
                size: 30,
                color: Palette.successColor,
              )),
        ),
      ),
    );
  }
}
