import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoping/core/manger/app_lang_cubit/app_lang_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/cache/cache_helper.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';

bool isArabic(BuildContext context) {
  final state = BlocProvider.of<AppLangCubit>(context).state;
  return state is AppChangeLang && state.languageCode == 'ar';
}

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  OnboardingPage(
                    title: AppLocalizations.of(context)!
                        .translate('updatedproductseveryday'),
                    description: AppLocalizations.of(context)!
                        .translate('dontworrywewontbeoutdated'),
                    imagePath: 'assets/images/ondroing1.svg',
                  ),
                  OnboardingPage(
                    title: AppLocalizations.of(context)!
                        .translate('easytransactionandpayment'),
                    description: AppLocalizations.of(context)!
                        .translate('yourpackageandserviceatyourdoor'),
                    imagePath: 'assets/images/onboring2.svg',
                  ),
                  OnboardingPage(
                    title: AppLocalizations.of(context)!
                        .translate('freeshippingvouchers'),
                    description: AppLocalizations.of(context)!
                        .translate('wecareaboutyourpackageasitsourown'),
                    imagePath: 'assets/images/ondroing3.svg',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => buildDot(index, context),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage != 2)
                    TextButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.translate('next'),
                        style: AppStyles.styleMedium20(context),
                      ),
                    ),
                  if (_currentPage == 2)
                    ElevatedButton(
                      onPressed: () {
                        CacheHelper()
                            .saveData(key: 'onboarding_seen', value: true);
                        GoRouter.of(context).push(AppRouter.kLoginView);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.translate('getStarted'),
                        style: AppStyles.styleMedium20(context),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? colorRed
            : isDarkMode
                ? Colors.white
                : Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * .3,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: AppStyles.styleSemiBold22nocolor(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppStyles.styleMedium20(context),
          ),
          const SizedBox(height: 40), // Added for spacing
        ],
      ),
    );
  }
}
