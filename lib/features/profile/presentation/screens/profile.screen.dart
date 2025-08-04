import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/widgets/ui_components/custom.textfield.dart';
import 'package:mentaura_app/core/widgets/ui_components/default.button.dart';
import 'package:mentaura_app/features/profile/presentation/widgets/log.out.sheet.dart';
import 'package:mentaura_app/core/widgets/phone.number.field.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/widgets/default.appbar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const routeName = "/profileScreen";
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();

  @override
  void initState() {
    final userDetails = ref.read(userDetailsProvider);
    nameEditingController.text = userDetails.name;

    phoneEditingController.text = userDetails.phoneNumber?.substring(3) ?? "";
    emailEditingController.text = userDetails.email ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDetailsProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SafeArea(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(
                screenName: "Profile",
                icon: Icons.settings,
              ),
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 60.r,
                backgroundColor: Palette.veryLightGreyColor,
                child: Text(
                  user.name[0].toUpperCase(),
                  style: CustomTextStyles.titleLargeBold(fontSize: 55.sp),
                ),
              ),
              Text(
                user.name,
                style: CustomTextStyles.titleLargeRegular(),
              ),
              Text(
                user.email ?? user.phoneNumber ?? "",
                style: CustomTextStyles.subtitleLargeRegular(),
              ),
              SizedBox(height: 25.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Edit Profile",
                  style: CustomTextStyles.subtitleLargeBold(
                      color: Palette.primaryBlackColor),
                ),
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                  hintText: "",
                  onPressed: () {},
                  controller: nameEditingController,
                  textInputType: TextInputType.text),
              SizedBox(height: 15.h),
              user.phoneNumber != null
                  ? PhoneNumberField(
                      phoneNumberController: phoneEditingController,
                      isProfileEdit: true,
                    )
                  : user.email != null
                      ? CustomTextField(
                          hintText: "",
                          onPressed: () {},
                          controller: emailEditingController,
                          textInputType: TextInputType.text)
                      : const SizedBox.shrink(),
              SizedBox(height: 15.h),
              DefaultButton(
                text: "Update Profile",
                press: () {},
                color: Palette.backgroundColor,
                isInvertColor: true,
              ),
              SizedBox(height: 15.h),
              Divider(
                color: Palette.lightGreyColor,
              ),
              SizedBox(height: 15.h),
              DefaultButton(
                text: "Delete Account",
                press: () {},
                color: Palette.backgroundColor,
                isInvertColor: true,
              ),
              SizedBox(height: 15.h),
              DefaultButton(
                text: "Log Out",
                press: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return LogOutSheet();
                      });
                },
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
