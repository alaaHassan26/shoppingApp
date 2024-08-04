import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';
import 'package:shoping/features/user/presentation/views/widget/user_update_profile_body.dart';

class UserUpdateProfileView extends StatefulWidget {
  const UserUpdateProfileView({super.key});

  @override
  State<UserUpdateProfileView> createState() => _UserUpdateProfileViewState();
}

class _UserUpdateProfileViewState extends State<UserUpdateProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        } else if (state is UpdateProfileSuccess) {
          context.read<UserCubit>().getUserProfile();
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: colorRed,
          ));
        } else if (state is ProfileSuccess) {
          return const SafeArea(child: UserUpdateProfileBody());
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: colorRed,
            ),
          );
        }
      },
    );
  }
}
