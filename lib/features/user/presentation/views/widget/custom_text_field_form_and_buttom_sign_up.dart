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

class CustomTextFielsFormAndButtomSignUp extends StatelessWidget {
  const CustomTextFielsFormAndButtomSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
            style: AppStyles.styleMedium20(context),
            message: state.message,
          ));
          GoRouter.of(context).go(AppRouter.kNavigationMenu);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMessage),
          ));
        }
      },
      builder: (context, state) {
        final userCubit = context.read<UserCubit>();
        return SizedBox(
          child: Form(
              key: userCubit.signUpFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.translate('name'),
                    controller: userCubit.signUpName,
                    errorText: userCubit.nameError,
                    onChanged: (_) => userCubit.clearNameError(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.translate('email'),
                    controller: userCubit.signUpEmail,
                    errorText: userCubit.emailError,
                    onChanged: (_) => userCubit.clearEmailError(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    labelText:
                        AppLocalizations.of(context)!.translate('password'),
                    isPassword: true,
                    controller: userCubit.signUpPassword,
                    errorText: userCubit.passwordError,
                    onChanged: (_) => userCubit.clearPasswordError(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.translate('phone'),
                    controller: userCubit.signUpPhoneNumber,
                  ),
                  AccountAndPassword(
                      text: AppLocalizations.of(context)!
                          .translate('haveaccount'),
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kLoginView);
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  state is SignUpLoading
                      ? const ShimmerButton()
                      : SizedBox(
                          width: double.infinity,
                          child: CustomButtom(
                            onPressed: () {
                              userCubit.signUp();
                            },
                            backGroundColor: colorRed,
                            text: AppLocalizations.of(context)!
                                .translate('signup'),
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
