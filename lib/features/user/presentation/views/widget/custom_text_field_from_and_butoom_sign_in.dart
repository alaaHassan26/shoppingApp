import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/core/widget/custom_buttom.dart';
import 'package:shoping/core/widget/shimmer_button.dart';
import 'package:shoping/core/widget/snak_bar.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';
import 'package:shoping/features/user/presentation/views/widget/account_and_password_buttom.dart';
import 'package:shoping/features/user/presentation/views/widget/custom_text_field.dart';

class CustomTextFieldFromAndSignIn extends StatelessWidget {
  const CustomTextFieldFromAndSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
            style: AppStyles.styleMedium20(context),
            message: state.message,
          ));
          context.read<UserCubit>().getUserProfile();
          GoRouter.of(context).go(AppRouter.kNavigationMenu);
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
            style: AppStyles.styleMedium20(context),
            message: state.errMessage,
          ));
        }
      },
      builder: (context, state) {
        final userCubit = context.read<UserCubit>();
        return SizedBox(
          child: Form(
              key: userCubit.signInFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.translate('email'),
                    controller: userCubit.signInEmail,
                    errorText: userCubit.emailError,
                    onChanged: (_) => userCubit.clearEmailError(),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    labelText:
                        AppLocalizations.of(context)!.translate('password'),
                    isPassword: true,
                    controller: userCubit.signInPassword,
                    errorText: userCubit.passwordError,
                    onChanged: (_) => userCubit.clearPasswordError(),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kForgotPassword);
                    },
                    child: AccountAndPassword(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kForgotPassword);
                      },
                      text: AppLocalizations.of(context)!
                          .translate('forgotpassword'),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: state is SignInLoading
                        ? const ShimmerButton()
                        : CustomButtom(
                            onPressed: () {
                              userCubit.signIn();
                            },
                            backGroundColor: colorRed,
                            text: AppLocalizations.of(context)!
                                .translate('login'),
                            textColor: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
