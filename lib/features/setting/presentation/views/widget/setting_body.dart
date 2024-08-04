import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoping/core/functions/theme_toggle_button.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/core/widget/custom_dropdown_lang.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTitleSetting(
              icon: Icons.language,
              title: AppLocalizations.of(context)!.translate('lang'),
              widget: const LanguageSelector(),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTitleSetting(
              icon: Iconsax.moon,
              title: AppLocalizations.of(context)!.translate('theme'),
              widget: const SizedBox(
                width: 100,
                child: ThemeToggleButton(),
              ),
            ),
            const SettingNumberBloc(),
          ],
        ),
      ),
    );
  }
}

class SettingNumberBloc extends StatelessWidget {
  const SettingNumberBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileSuccess) {
          final user = state.user.data;
          return Column(
            children: [
              ListTitleSetting(
                icon: Icons.phone,
                title: user.phone,
                widget: const Text(''),
              ),
              ListTitleSetting(
                icon: Icons.email,
                title: user.email,
                widget: const Text(''),
              ),
            ],
          );
        } else if (state is ProfileFailure) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(color: colorRed),
            ),
          );
        } else {
          return const Center(child: Text('No profile data'));
        }
      },
    );
  }
}

class ListTitleSetting extends StatelessWidget {
  const ListTitleSetting(
      {super.key,
      required this.icon,
      required this.title,
      required this.widget});
  final IconData icon;
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: FittedBox(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.scaleDown,
          child: Icon(icon),
        ),
        title: FittedBox(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.scaleDown,
          child: FittedBox(
            alignment: AlignmentDirectional.centerStart,
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: AppStyles.styleSemiBold20(context),
            ),
          ),
        ),
        trailing: widget,
      ),
    );
  }
}
