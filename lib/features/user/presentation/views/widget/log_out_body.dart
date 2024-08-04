import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/core/api/end_ponits.dart';

import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/widget/custom_buttom.dart';
import 'package:shoping/core/widget/shimmer_button.dart';
import 'package:shoping/core/widget/snak_bar.dart';

import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';

class LogoutBody extends StatelessWidget {
  const LogoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
            style: AppStyles.styleMedium20(context),
            message: state.message,
          ));
          GoRouter.of(context).go(AppRouter.kLoginView);
        } else if (state is LogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is LogoutLoading) {
          return const ShimmerButton();
        }

        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: CustomButtom(
              backGroundColor: const Color.fromARGB(255, 238, 181, 177),
              text: AppLocalizations.of(context)!.translate('logout'),
              textColor: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              onPressed: () {
                String fcmToken = ApiKey.token;
                context.read<UserCubit>().logout(fcmToken);
              },
            ),
          ),
          // ElevatedButton(

          //   onPressed: () {
          //     String fcmToken =
          //         ApiKey.token; // استبدل هذه القيمة بالتوكن الفعلي
          //     context.read<UserCubit>().logout(fcmToken);
          //   },
          //   child: const Text('Logout'),
          // ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shoping/core/api/end_ponits.dart';
// import 'package:shoping/core/utils/app_router.dart';
// import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';

// class LogoutBody extends StatelessWidget {
//   const LogoutBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Logout'),
//       ),
//       body: BlocConsumer<UserCubit, UserState>(
//         listener: (context, state) {
//           if (state is LogoutSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Logout successful')),
//             );
//             GoRouter.of(context).push(AppRouter.kLoginView);
//           } else if (state is LogoutFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.error)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is LogoutLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 String fcmToken = ApiKey.token;
//                 context.read<UserCubit>().logout(fcmToken);
//               },
//               child: const Text('Logout'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
