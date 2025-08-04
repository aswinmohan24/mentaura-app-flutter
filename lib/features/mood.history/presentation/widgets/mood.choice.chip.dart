import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mentaura_app/core/constants/constants.dart';

import '../../../../core/theme/color.palette.dart';
import '../../providers/activity.provider.dart';

class MoodChoiceChip extends ConsumerWidget {
  const MoodChoiceChip(
      {super.key, required this.moodNameList, required this.controller});

  final List<String> moodNameList;
  final AnimationController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Wrap(
        spacing: 14,
        children: moodNameList.map((moodName) {
          final selectedMood = ref.read(moodChipChangeProvider);
          return ChoiceChip(
            showCheckmark: false,
            labelStyle: TextStyle(
                color: selectedMood == moodName
                    ? Palette.backgroundColor
                    : Palette.primaryTextColor,
                fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: .8,
                    color: selectedMood == moodName
                        ? Colors.transparent
                        : Palette.kThirdGreenColor),
                borderRadius: BorderRadius.circular(chipBorderRadius)),
            color: WidgetStatePropertyAll(
              selectedMood == moodName
                  ? Palette.kPrimaryGreenColor
                  : Palette.backgroundColor,
            ),
            label: Text(moodName),
            selected: selectedMood == moodName,
            onSelected: (bool selected) {
              ref.read(moodChipChangeProvider.notifier).state =
                  selected ? moodName : "All";
            },
          );
        }).toList(),
      ),
    );
  }
}
