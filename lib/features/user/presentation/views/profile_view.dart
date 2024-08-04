import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';
import 'package:shoping/features/user/presentation/views/widget/profile_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<UserCubit>().getUserProfile();
      },
      child: const Scaffold(
        body: SafeArea(child: ProfileBody()),
      ),
    );
  }
}
