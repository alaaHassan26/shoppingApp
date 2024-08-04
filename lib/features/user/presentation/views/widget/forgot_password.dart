import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/core/widget/custom_buttom.dart';
import 'package:shoping/core/widget/snak_bar.dart';

import 'package:shoping/features/user/presentation/views/widget/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _handleSubmit() {
    final email = _emailController.text;

    setState(() {
      if (email.isEmpty) {
        _errorMessage =
            AppLocalizations.of(context)!.translate('emailcannotbeempty');
      } else if (!_isEmailValid(email)) {
        _errorMessage =
            AppLocalizations.of(context)!.translate('invalidemailaddress');
      } else {
        _errorMessage = null;
        ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
          style: AppStyles.styleMedium20(context),
          message: AppLocalizations.of(context)!.translate('checkyouremail'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Card(
                  color: const Color.fromARGB(255, 226, 194, 191),
                  child: IconButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kLoginView);
                      },
                      icon: const Icon(
                        Iconsax.back_square,
                        color: colorRed,
                      )),
                ),
                const SizedBox(
                  height: 42,
                ),
                FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('forgotpassword1'),
                      style: AppStyles.styleSemiBold34(context),
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Text(
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.styleMedium16(context),
                    AppLocalizations.of(context)!.translate('enteremail'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: _emailController,
                  labelText: AppLocalizations.of(context)!.translate('email'),
                  errorText: _errorMessage,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtom(
                    onPressed: _handleSubmit,
                    backGroundColor: colorRed,
                    text: AppLocalizations.of(context)!.translate('sendemail'),
                    textColor: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
