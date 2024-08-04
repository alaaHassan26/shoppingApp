import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoping/core/manger/internet_cubit/internet_cubit.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';
import 'package:shoping/features/user/data/models/custom_item_model/custom_item_model.dart';
import 'package:shoping/features/user/presentation/views/widget/custom_listtitle.dart';

class UserInfoListTile extends StatelessWidget {
  const UserInfoListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileSuccess) {
          final user = state.user.data;
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kUserUpdateProfileView);
            },
            child: Card(
              elevation: 0,
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: CustomListTile(
                        customItemModel: CustomItemModel(
                          textTitle: user.name,
                          textSubTitle: user.email,
                          trailing: const Icon(Iconsax.arrow_right),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProfileFailure) {
          return BlocProvider(
            create: (_) => InternetCubit(),
            child: BlocBuilder<InternetCubit, InternetStatus>(
              builder: (context, state) {
                return state.status == ConnectivityStatus.disconnected
                    ? Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .translate('nointernetconnection'),
                            style: AppStyles.styleMedium20(context),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Icon(Icons.signal_wifi_bad),
                        ],
                      )
                    : Center(
                        child: Text(
                          AppLocalizations.of(context)!.translate('error'),
                          style: AppStyles.styleMedium20(context),
                        ),
                      );
              },
            ),
          );
        } else {
          return Center(
              child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.translate('loggiingout'),
                style: AppStyles.styleMedium20(context),
              ),
              const SizedBox(
                width: 12,
              ),
              const Icon(Icons.login_outlined),
            ],
          ));
        }
      },
    );
  }
}
