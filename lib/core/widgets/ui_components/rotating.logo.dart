import 'package:flutter/material.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class RotatingLogo extends StatefulWidget {
  const RotatingLogo({super.key});

  @override
  State<RotatingLogo> createState() => _RotatingLogoState();
}

class _RotatingLogoState extends State<RotatingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Palette.backgroundColor,
        backgroundImage: AssetImage("assets/images/mentaura_logo_green.png"),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
