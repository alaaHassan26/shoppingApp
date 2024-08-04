import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:shoping/core/utils/service_locator.dart';
import 'package:shoping/features/details/custom_details_view_item.dart';
import 'package:shoping/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:shoping/features/favorites/presentation/manger/cubit/favorite_cubit.dart';

import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/data/repos/home_repos_impl.dart';
import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/clothes_view_all.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/electroin_deviecs_view_all.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/medical_view_all.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/new_view_all.dart';
import 'package:shoping/features/home/presentation/views/home_view_all/sports_view_all.dart';
import 'package:shoping/features/order/presentation/manger/cubit/cart_cubit.dart';
import 'package:shoping/features/saplash/presentation/view/saplash_view.dart';
import 'package:shoping/features/saplash/presentation/view/widget/onboarding.dart';
import 'package:shoping/features/setting/presentation/views/payment_view.dart';

import 'package:shoping/features/setting/presentation/views/setting_view.dart';
import 'package:shoping/features/shop/data/repos/shop_repo_impl.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:shoping/features/shop/presentation/view/shop_view_new.dart';
import 'package:shoping/features/user/data/repos/user_repo_impl.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';

import 'package:shoping/features/user/presentation/views/sign_in_view.dart';
import 'package:shoping/features/user/presentation/views/sign_up_view.dart';

import 'package:shoping/features/user/presentation/views/user_update_profile_view.dart';
import 'package:shoping/features/user/presentation/views/widget/forgot_password.dart';
import 'package:shoping/navigation_menu.dart';

abstract class AppRouter {
  static const kPaymentView = '/paymentView';
  static const kForgotPassword = '/forgotPassword';
  static const kSignUpView = '/signUpView';
  static const kLoginView = '/loginView';
  static const kUserUpdateProfileView = '/userUpdateProfileView';
  static const kUpdateProfileView = '/updateProfileView';
  static const kNavigationMenu = '/navigationMenu';
  static const kSettingView = '/settingView';
  static const kNewViewAll = '/newViewAll';
  static const kMedicalViewAll = '/medicalViewAll';
  static const kEletroinDeviecsViewAll = '/eletroinDeviecsViewAll';
  static const kSportsViewAll = '/sportsViewAll';
  static const kClothesViewAll = '/clothesViewAll';
  static const kCustomDetailsViewItem = '/customDetailsViewItem';
  static const kProductsAll = '/productsAll';
  static const kOnboarding = '/onboarding';
  static const kCartPage = '/cartPage';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboarding,
        builder: (context, state) => const OnboardingScreens(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit(getIt.get<UserRepoImpl>(), context),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit(getIt.get<UserRepoImpl>(), context),
          child: const SignUpView(),
        ),
      ),
      GoRoute(
        path: kUserUpdateProfileView,
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit(getIt.get<UserRepoImpl>(), context),
          child: const UserUpdateProfileView(),
        ),
      ),
      GoRoute(
        path: kNavigationMenu,
        builder: (context, state) => const NavigationMenu(),
      ),
      GoRoute(
        path: kSettingView,
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit(getIt.get<UserRepoImpl>(), context),
          child: const SettingView(),
        ),
      ),
      GoRoute(
          path: kNewViewAll,
          builder: (context, state) => MultiBlocProvider(providers: [
                BlocProvider(
                  create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())
                    ..getProdctsNew(num: 40),
                ),
                BlocProvider(
                  create: (context) =>
                      FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
                )
              ], child: const NewViewAll())),
      GoRoute(
        path: kMedicalViewAll,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())
              ..getProdctsMedical(num: 43),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
          )
        ], child: const MedicalViewAll()),
      ),
      GoRoute(
        path: kEletroinDeviecsViewAll,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())
              ..getProdctsElectronicDevices(num: 46),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
          )
        ], child: const EletroinDeviecsViewAll()),
      ),
      GoRoute(
        path: kSportsViewAll,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) =>
                HomeCubit(getIt.get<HomeRepoImpl>())..getProdctsSports(num: 42),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
          )
        ], child: const SportsViewAll()),
      ),
      GoRoute(
        path: kClothesViewAll,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())
              ..getProdctsClothes(num: 46),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
          )
        ], child: const ClothesViewAll()),
      ),
      GoRoute(
          path: kCustomDetailsViewItem,
          builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())
                      ..getProdctsClothes(num: 46),
                  ),
                  BlocProvider(
                    create: (context) =>
                        FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
                  ),
                  BlocProvider(
                    create: (context) => CartCubit(),
                  ),
                ],
                child: CustomDetailsViewItem(
                  productModel: state.extra as ProductModel,
                ),
              )),
      GoRoute(
        path: kProductsAll,
        builder: (context, state) => BlocProvider(
            create: (context) => ShopCubit(getIt.get<ShopRepoImpl>()),
            child: const ShopViewNew()),
      ),
      GoRoute(
        path: kForgotPassword,
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit(getIt.get<UserRepoImpl>(), context),
          child: const ForgotPassword(),
        ),
      ),
      GoRoute(
        path: kPaymentView,
        builder: (context, state) => const PaymentView(),
      ),
    ],
  );
}
