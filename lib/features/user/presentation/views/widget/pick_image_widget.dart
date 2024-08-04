import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        final userCubit = context.read<UserCubit>();
        return Column(
          children: [
            SizedBox(
              width: 130,
              height: 130,
              child: userCubit.profilePic == null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                          const AssetImage("assets/images/avatar.png"),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () async {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  userCubit.uploadProfilePic(image);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              FileImage(File(userCubit.profilePic!.path)),
                          radius: 65,
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                userCubit.uploadProfilePic(image);
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            if (userCubit.profilePicError !=
                null) // عرض رسالة الخطأ إذا كانت موجودة
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  AppLocalizations.of(context)!
                      .translate('theimagemustnotbeempty'),
                  style: AppStyles.styleRegular14v2(context)
                      .copyWith(color: colorRed),
                ),
              ),
          ],
        );
      },
    );
  }
}
