import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/setting/presentation/views/widget/setting_body.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('setting'),
          style: AppStyles.styleSemiBold34(context),
        ),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: const SafeArea(child: SettingBody()),
    );
  }
}
