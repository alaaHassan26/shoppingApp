// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/svg.dart';
import 'package:shoping/cache/cache_helper.dart';
import 'package:shoping/core/api/end_ponits.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/core/utils/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    bool? onboardingSeen = CacheHelper().getData(key: 'onboarding_seen');
    if (onboardingSeen == null || !onboardingSeen) {
      GoRouter.of(context).go('/onboarding');
    } else {
      CacheHelper().getData(key: ApiKey.token) != null
          ? GoRouter.of(context).go(AppRouter.kNavigationMenu)
          : GoRouter.of(context).go(AppRouter.kLoginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/splashImage.svg',
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .3,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'S',
                  style: AppStyles.styleSemiBold22nocolor(context)
                      .copyWith(color: colorRed, fontSize: 60),
                ),
                Text(
                  'hopping',
                  style: AppStyles.styleSemiBold22nocolor(context)
                      .copyWith(color: Colors.blue, fontSize: 40),
                ),
                Text(
                  'S',
                  style: AppStyles.styleSemiBold22nocolor(context)
                      .copyWith(color: colorRed, fontSize: 60),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
