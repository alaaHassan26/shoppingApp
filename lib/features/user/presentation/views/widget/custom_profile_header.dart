import 'package:flutter/material.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/user/data/models/user_profile_model/user_profile_model.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader({
    super.key,
    required this.user,
  });
  final UserProfileModel user;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorRed,
      child: Column(
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.data.image),
          ),
          const SizedBox(height: 10),
          Text(
            user.data.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
