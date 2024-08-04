import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';

import 'package:shoping/features/user/presentation/views/widget/custom_text_field_form_and_buttom_sign_up.dart';
import 'package:shoping/features/user/presentation/views/widget/pick_image_widget.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kLoginView);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 26,
                  )),
              const SizedBox(
                height: 24,
              ),
              Text(
                AppLocalizations.of(context)!.translate('signup'),
                style: AppStyles.styleSemiBold24(context),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(child: PickImageWidget()),
              const SizedBox(
                height: 20,
              ),
              const CustomTextFielsFormAndButtomSignUp(),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
