import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/manger/internet_cubit/internet_cubit.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/favorites/presentation/views/widget/favorite_page.dart';
import 'package:shoping/features/favorites/presentation/views/widget/favorite_product_item_shimmer.dart';

class FavoriteBody extends StatefulWidget {
  const FavoriteBody({super.key});

  @override
  State<StatefulWidget> createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  bool _initialCheck = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternetCubit(),
      child: BlocListener<InternetCubit, InternetStatus>(
        listener: (context, state) {
          if (state.status == ConnectivityStatus.checking) {
            setState(() {
              _initialCheck = true;
            });
          } else {
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                setState(() {
                  _initialCheck = false;
                });
              }
            });
          }
        },
        child: BlocBuilder<InternetCubit, InternetStatus>(
          builder: (context, state) {
            if (_initialCheck) {
              return const Center(child: ShimmerBestSeller());
            } else if (state.status == ConnectivityStatus.connected) {
              return const FavoritePage();
            } else {
              return const NoInternetScreen();
            }
          },
        ),
      ),
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 100),
            const SizedBox(height: 16),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                AppLocalizations.of(context)!.translate('nointernetconnection'),
                style: AppStyles.styleSemiBold22nocolor(context),
              ),
            ),
            const SizedBox(height: 16),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                  AppLocalizations.of(context)!
                      .translate('trythesestepstoreconnecttotheinternet'),
                  style: AppStyles.styleRegular16(context)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                      AppLocalizations.of(context)!
                          .translate('checkthemodemandtherouter'),
                      style: AppStyles.styleRegular16(context)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                      AppLocalizations.of(context)!
                          .translate('reconnecttothewifinetwork'),
                      style: AppStyles.styleRegular16(context)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<InternetCubit>().checkConnectivity();
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppLocalizations.of(context)!.translate('reloadthepage'),
                  style: AppStyles.styleRegular16(context)
                      .copyWith(color: colorRed),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
