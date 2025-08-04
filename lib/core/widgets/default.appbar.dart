import 'package:flutter/material.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';

class DefaultAppBar extends StatelessWidget {
  final String screenName;
  final bool implyLeading;
  final bool largerTitle;
  final bool ceneterTitle;
  final IconData icon;

  const DefaultAppBar({
    required this.screenName,
    super.key,
    this.implyLeading = false,
    this.largerTitle = true,
    this.ceneterTitle = false,
    this.icon = Icons.more_vert_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: [
          implyLeading
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back))
              : const SizedBox.shrink(),
          const SizedBox(width: 5),
          Text(
            screenName,
            style: largerTitle
                ? CustomTextStyles.titleLargeRegular()
                : CustomTextStyles.subtitleLargeSemiBold(
                    color: Palette.primaryBlackColor),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: Icon(icon))
        ],
      ),
    );
  }
}
