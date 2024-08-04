import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/core/functions/theme_toggle_button.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/core/widget/custom_buttom.dart';
import 'package:shoping/core/widget/custom_dropdown_lang.dart';

import 'package:shoping/features/user/presentation/views/widget/custom_text_field_from_and_butoom_sign_in.dart';
// تضمين ملف اختيار اللغة

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.translate('login'),
              style: AppStyles.styleSemiBold24(context),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 26,
            ),
            const Row(
              children: [
                LanguageSelector(),
                Spacer(),
                ThemeToggleButton(),
              ],
            ),
            const SizedBox(
              height: 96,
            ),
            const CustomTextFieldFromAndSignIn(),
            const SizedBox(
              height: 48,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  child: CustomButtom(
                    backGroundColor: colorRed,
                    text: AppLocalizations.of(context)!.translate('notaccount'),
                    textColor: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kSignUpView);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
