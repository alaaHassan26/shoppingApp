import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/colors.dart';

import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';

class UserUpdateProfileBody extends StatefulWidget {
  const UserUpdateProfileBody({super.key});

  @override
  State<StatefulWidget> createState() => _UserUpdateProfileBodyState();
}

class _UserUpdateProfileBodyState extends State<UserUpdateProfileBody> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    final userCubit = context.read<UserCubit>();
    if (userCubit.userProfile != null) {
      userCubit.updateUpName.text = userCubit.userProfile?.data.name ?? '';
      userCubit.updateEmail.text = userCubit.userProfile?.data.email ?? '';
      userCubit.updatePhoneNumber.text =
          userCubit.userProfile?.data.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        } else if (state is UpdateProfileSuccess) {
          setState(() {
            isEditing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
        } else if (state is UpdateProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileSuccess || state is UserInitial) {
          final user = userCubit.userProfile?.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorRed,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(isEditing ? Icons.save : Icons.edit,
                      color: Colors.white),
                  onPressed: () {
                    if (isEditing) {
                      if (userCubit.updateProfileKey.currentState!.validate()) {
                        userCubit.updateUserProfile();
                      }
                    } else {
                      setState(() {
                        isEditing = true;
                        userCubit.updateUpName.text = user?.name ?? '';
                        userCubit.updateEmail.text = user?.email ?? '';
                        userCubit.updatePhoneNumber.text = user?.phone ?? '';
                      });
                    }
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: userCubit.updateProfileKey,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(user?.image ?? ''),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: userCubit.updateUpName,
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .translate('name')),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  } else if (value.length < 4) {
                                    return 'Name must be at least 4 characters';
                                  }
                                  return null;
                                },
                                enabled: isEditing,
                              ),
                              TextFormField(
                                controller: userCubit.updateEmail,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .translate('email'),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                enabled: isEditing,
                              ),
                              TextFormField(
                                controller: userCubit.updatePhoneNumber,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .translate('phone'),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                                enabled: isEditing,
                              ),
                              const SizedBox(height: 20),
                              if (isEditing)
                                ElevatedButton(
                                  onPressed: () {
                                    if (userCubit.updateProfileKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        userCubit.updateUserProfile();
                                      });
                                    }
                                  },
                                  child: const Text('Save'),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (state is ProfileLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator(
            color: colorRed,
          );
        }
      },
    );
  }
}
