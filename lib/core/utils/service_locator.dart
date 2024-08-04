import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shoping/core/api/dio_consumer.dart';
import 'package:shoping/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:shoping/features/home/data/repos/home_repos_impl.dart';
import 'package:shoping/features/shop/data/repos/shop_repo_impl.dart';
import 'package:shoping/features/user/data/repos/user_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register DioConsumer once
  getIt.registerSingleton<DioConsumer>(DioConsumer(Dio()));

  // Register UserRepoImpl
  getIt.registerSingleton<UserRepoImpl>(
    UserRepoImpl(
      getIt.get<DioConsumer>(),
    ),
  );

  // Register HomeRepoImpl
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt.get<DioConsumer>(),
    ),
  );

  // Register ShopRepoImpl
  getIt.registerSingleton<ShopRepoImpl>(
    ShopRepoImpl(
      getIt.get<DioConsumer>(),
    ),
  );

  getIt.registerSingleton<FavoritesRepoImpl>(
    FavoritesRepoImpl(
      getIt.get<DioConsumer>(),
    ),
  );
}

// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shoping/core/api/dio_consumer.dart';
// import 'package:shoping/features/home/data/repos/home_repos_impl.dart';

// import 'package:shoping/features/user/data/repos/user_repo_impl.dart';

// final getIt = GetIt.instance;
// void setupServiceLocator() {
//   getIt.registerSingleton<DioConsumer>(DioConsumer(Dio()));
//   getIt.registerSingleton<UserRepoImpl>(
//     UserRepoImpl(
//       getIt.get<DioConsumer>(),
//     ),
//   );
//   //////////////////////////////////////////////////
//   getIt.registerSingleton<DioConsumer>(DioConsumer(Dio()));
//   getIt.registerSingleton<HomeRepoImpl>(
//     HomeRepoImpl(
//       getIt.get<DioConsumer>(),
//     ),
//   );
// }
