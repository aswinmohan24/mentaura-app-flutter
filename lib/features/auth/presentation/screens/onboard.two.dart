import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/constants/constants.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/widgets/dialogs.dart';
import 'package:mentaura_app/core/utils/string.utils.dart';
import 'package:mentaura_app/features/auth/models/user.details.model.dart';
import 'package:mentaura_app/core/widgets/ui_components/custom.textfield.dart';
import 'package:mentaura_app/core/widgets/ui_components/default.button.dart';
import 'package:mentaura_app/app/bottom_bar.dart';

class OnboardTwoScreen extends ConsumerStatefulWidget {
  static const routeName = "/onboardTwoScreen";
  const OnboardTwoScreen({super.key});

  @override
  ConsumerState<OnboardTwoScreen> createState() => _OnboardTwoScreenState();
}

class _OnboardTwoScreenState extends ConsumerState<OnboardTwoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  List<String> genders = ['Male', 'Female', 'Other'];
  String selectedGender = "Male";
  late String randomString;

  @override
  void initState() {
    randomString = StringUtil.getRandomString(loadingTextList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: screenMainHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete your profile',
              style: CustomTextStyles.titleLargeRegular(),
            ),
            const SizedBox(height: 30),
            Text(
              ' Name',
              style: CustomTextStyles.subtitleLargeBold(
                  color: Palette.primaryTextColor),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: nameController,
              textInputType: TextInputType.name,
              hintText: "John Doe",
              onPressed: () {},
            ),
            const SizedBox(height: 15),
            Text(
              ' Age',
              style: CustomTextStyles.subtitleLargeBold(
                  color: Palette.primaryTextColor),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: ageController,
              textInputType: TextInputType.number,
              hintText: "25",
              onPressed: () {},
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2)
              ],
            ),
            const SizedBox(height: 15),
            Text(
              ' Gender',
              style: CustomTextStyles.subtitleLargeBold(
                  color: Palette.primaryTextColor),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: genders.map((gender) {
                return ChoiceChip(
                  showCheckmark: false,
                  labelStyle: TextStyle(
                      color: selectedGender == gender
                          ? Palette.backgroundColor
                          : Palette.primaryTextColor,
                      fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(chipBorderRadius)),
                  color: WidgetStatePropertyAll(
                    selectedGender == gender
                        ? Palette.kPrimaryGreenColor
                        : Palette.lightYellowAccent,
                  ),
                  label: Text(gender),
                  selected: selectedGender == gender,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedGender = selected ? gender : "  Male";
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            DefaultButton(
                text: 'Finish',
                press: () {
                  saveAndProceed(ref);
                })
          ],
        ),
      ),
    );
  }

  void saveAndProceed(WidgetRef ref) async {
    final navContext = Navigator.of(context);
    final phoneNumber = ref.read(userPhoneNumberProvider);
    if (nameController.text.isEmpty && ageController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter name and age to proceed");
    } else if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter name to proceed");
    } else if (ageController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter age to proceed");
    } else {
      ref.read(userNameProvider.notifier).state = nameController.text;
      AppDialogs.showFullScreenLOader(
          context: context, dialogText: randomString);
      if (phoneNumber != null) {
        await ref.read(userAuthRepositoryProvider).createUser(UserDetails(
            name: nameController.text,
            phoneNumber: ref.read(userPhoneNumberProvider.notifier).state ?? "",
            age: ageController.text,
            gender: selectedGender));
        ref.read(bottomNavIndexProvider.notifier).state = 0;
        await Future.delayed(Duration(seconds: 1));
        navContext.pushNamedAndRemoveUntil(
            BottomBar.routeName, (route) => false);
      } else {
        await ref.read(userAuthRepositoryProvider).createUser(UserDetails(
            name: nameController.text,
            email: ref.read(googleEmailIdProvider.notifier).state ?? "",
            age: ageController.text,
            gender: selectedGender));
        ref.read(bottomNavIndexProvider.notifier).state = 0;

        await Future.delayed(Duration(seconds: 1));
        navContext.pushNamedAndRemoveUntil(
            BottomBar.routeName, (route) => false);
      }
    }
  }
}
