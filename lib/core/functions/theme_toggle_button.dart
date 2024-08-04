import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/manger/app_theme_cubit/app_theme_cubit.dart';
import 'package:shoping/core/models/Enums/theme_state.dart';
import 'package:shoping/core/utils/colors.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isDarkMode
            ? const Icon(Icons.light_mode)
            : const Icon(Icons.nights_stay),
        const SizedBox(
          width: 12,
        ),
        Switch(
          activeColor: colorRed,
          value: isDarkMode,
          onChanged: (value) {
            var themeCubit = context.read<AppThemeCubit>();
            if (value) {
              themeCubit.changeTheme(ThemeState.dark);
            } else {
              themeCubit.changeTheme(ThemeState.ligth);
            }
          },
        ),
      ],
    );
  }
}
