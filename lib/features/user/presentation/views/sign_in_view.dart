import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoping/core/manger/internet_cubit/internet_cubit.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/widget/snak_bar.dart';
import 'package:shoping/features/user/presentation/views/widget/sign_in_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    bool initialCheck = true;
    bool isDisconnected = false;
    return Scaffold(
      body: BlocProvider(
        create: (_) => InternetCubit(),
        child: BlocListener<InternetCubit, InternetStatus>(
          listener: (context, state) {
            if (initialCheck) {
              initialCheck = false;
              if (state.status == ConnectivityStatus.disconnected) {
                isDisconnected = true;
                ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
                  style: AppStyles.styleMedium20(context),
                  message: AppLocalizations.of(context)!
                      .translate('nointernetconnection'),
                ));
              }
            } else {
              if (state.status == ConnectivityStatus.disconnected) {
                isDisconnected = true;
                ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
                  style: AppStyles.styleMedium20(context),
                  message: AppLocalizations.of(context)!
                      .translate('nointernetconnection'),
                ));
              } else if (state.status == ConnectivityStatus.connected &&
                  isDisconnected) {
                isDisconnected = false;
                ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
                  style: AppStyles.styleMedium20(context),
                  color: Colors.green,
                  message: AppLocalizations.of(context)!
                      .translate('internetconnectionrestored'),
                ));
              }
            }
          },
          child: const SignInBody(),
        ),
      ),
    );
  }
}
