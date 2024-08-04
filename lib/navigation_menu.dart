import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:shoping/core/manger/internet_cubit/internet_cubit.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/service_locator.dart';
import 'package:shoping/core/widget/snak_bar.dart';
import 'package:shoping/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:shoping/features/favorites/presentation/manger/cubit/favorite_cubit.dart';
import 'package:shoping/features/favorites/presentation/views/favorite_view.dart';
import 'package:shoping/features/home/data/repos/home_repos_impl.dart';
import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:shoping/features/home/presentation/views/prodcts_view.dart';
import 'package:shoping/features/order/presentation/manger/cubit/cart_cubit.dart';
import 'package:shoping/features/order/presentation/views/widget/cart_page.dart';
import 'package:shoping/features/shop/data/repos/shop_repo_impl.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:shoping/features/shop/presentation/view/shop_view_new.dart';
import 'package:shoping/features/user/data/repos/user_repo_impl.dart';
import 'package:shoping/features/user/presentation/manger/user_cubit/user_cubit.dart';
import 'package:shoping/features/user/presentation/views/profile_view.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  bool _initialCheck = true;
  bool _isDisconnected = false;

  final bool _isAtTop = true;

  final List<Widget> _screens = [];

  void initScreens() {
    _screens.addAll([
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(getIt.get<HomeRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
          ),
        ],
        child: const ProductsView(),
      ),
      BlocProvider(
        create: (context) => ShopCubit(getIt.get<ShopRepoImpl>()),
        child: const ShopViewNew(),
      ),
      BlocProvider(
        create: (context) => FavoriteCubit(getIt.get<FavoritesRepoImpl>()),
        child: const FavoriteView(),
      ),
      BlocProvider(
        create: (context) => CartCubit(),
        child: const CartPage(),
      ),
      BlocProvider(
        create: (context) => UserCubit(getIt.get<UserRepoImpl>(), context),
        child: const ProfileView(),
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    initScreens();

    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    context.read<InternetCubit>().close();

    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (_selectedIndex == 0) {
      if (_isAtTop) {
        return false;
      } else {
        return true;
      }
    } else {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _selectedIndex = 0;
        });
      }
      return true;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternetCubit(),
      child: BlocListener<InternetCubit, InternetStatus>(
        listener: (context, state) {
          if (_initialCheck) {
            _initialCheck = false;
            if (state.status == ConnectivityStatus.disconnected) {
              _isDisconnected = true;
              ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
                style: AppStyles.styleMedium20(context),
                message: AppLocalizations.of(context)!
                    .translate('nointernetconnection'),
              ));
            }
          } else {
            if (state.status == ConnectivityStatus.disconnected) {
              _isDisconnected = true;
              ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
                style: AppStyles.styleMedium20(context),
                message: AppLocalizations.of(context)!
                    .translate('nointernetconnection'),
              ));
            } else if (state.status == ConnectivityStatus.connected &&
                _isDisconnected) {
              _isDisconnected = false;
              ScaffoldMessenger.of(context).showSnackBar(customSnakBar(
                style: AppStyles.styleMedium20(context),
                color: Colors.green,
                message: AppLocalizations.of(context)!
                    .translate('internetconnectionrestored'),
              ));
            }
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.home),
                label: AppLocalizations.of(context)!.translate('home1'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.shop),
                label: AppLocalizations.of(context)!.translate('store'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.heart),
                label: AppLocalizations.of(context)!.translate('favorite1'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.shopping_cart),
                label: AppLocalizations.of(context)!.translate('cart'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Iconsax.user),
                label: AppLocalizations.of(context)!.translate('profile'),
              ),
            ],
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: AppStyles.styleBold16(context),
            unselectedLabelStyle: AppStyles.styleMedium16(context),
            showUnselectedLabels: true,
          ),
          body: _screens[_selectedIndex],
        ),
      ),
    );
  }
}
