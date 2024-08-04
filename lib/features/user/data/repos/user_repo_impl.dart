import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoping/cache/cache_helper.dart';
import 'package:shoping/core/api/api_consumer.dart';
import 'package:shoping/core/api/end_ponits.dart';
import 'package:shoping/core/errors/failure.dart';
import 'package:shoping/core/functions/upload_image_to_api.dart';
import 'package:shoping/features/user/data/models/log_out_model/log_out_model.dart';
import 'package:shoping/features/user/data/models/sign_in_model/sign_in_model.dart';
import 'package:shoping/features/user/data/models/sign_up_model/sign_up_model.dart';
import 'package:shoping/features/user/data/models/user_profile_model/user_profile_model.dart';
import 'package:shoping/features/user/data/models/update_profile_model/update_profile_model.dart';
import 'package:shoping/features/user/data/repos/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final ApiConsumer api;

  UserRepoImpl(this.api);

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile() async {
    try {
      final cachedName = await CacheHelper().getData(key: ApiKey.name);
      final cachedEmail = await CacheHelper().getData(key: ApiKey.email);
      final cachedPhone = await CacheHelper().getData(key: ApiKey.phone);
      final cachedImage = await CacheHelper().getData(key: ApiKey.image);

      if (cachedName != null &&
          cachedEmail != null &&
          cachedPhone != null &&
          cachedImage != null) {
        final userProfile = UserProfileModel(
          data: UserProfileData(
            id: await CacheHelper().getData(key: ApiKey.id),
            name: cachedName,
            email: cachedEmail,
            phone: cachedPhone,
            image: cachedImage,
          ),
        );
        return right(userProfile);
      } else {
        final response = await api.get(EndPonit.userProfile);
        final userProfile = UserProfileModel.fromJson(response);
        await CacheHelper()
            .saveData(key: ApiKey.name, value: userProfile.data.name);
        await CacheHelper()
            .saveData(key: ApiKey.email, value: userProfile.data.email);
        await CacheHelper()
            .saveData(key: ApiKey.phone, value: userProfile.data.phone);
        await CacheHelper()
            .saveData(key: ApiKey.image, value: userProfile.data.image);
        await CacheHelper()
            .saveData(key: ApiKey.id, value: userProfile.data.id);
        return right(userProfile);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(EndPonit.signIn, data: {
        ApiKey.email: email,
        ApiKey.password: password,
      });
      final user = SignInModel.fromJson(response);
      CacheHelper().saveData(key: ApiKey.token, value: user.data!.token);
      CacheHelper().saveData(key: ApiKey.id, value: user.data!.id);
      CacheHelper().saveData(key: 'isLoggedin', value: true);
      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignUpModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required XFile image,
  }) async {
    try {
      final response = await api.post(EndPonit.signUp, isFormData: true, data: {
        ApiKey.name: name,
        ApiKey.email: email,
        ApiKey.password: password,
        ApiKey.phone: phone,
        ApiKey.image: await uploadImageToAPI(image),
      });
      final signUpModel = SignUpModel.fromJson(response);

      CacheHelper().saveData(key: ApiKey.token, value: signUpModel.data!.token);
      CacheHelper().saveData(key: ApiKey.id, value: signUpModel.data!.id);
      CacheHelper().saveData(key: 'isLoggedin', value: true);
      return right(signUpModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileModel>> updateUserProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final response = await api.put(EndPonit.updateProfile, data: {
        ApiKey.name: name,
        ApiKey.email: email,
        ApiKey.phone: phone,
      });
      final updateUser = UpdateProfileModel.fromJson(response);
      await CacheHelper()
          .saveData(key: ApiKey.name, value: updateUser.data.name);
      await CacheHelper()
          .saveData(key: ApiKey.email, value: updateUser.data.email);
      await CacheHelper()
          .saveData(key: ApiKey.phone, value: updateUser.data.phone);
      await CacheHelper()
          .saveData(key: ApiKey.image, value: updateUser.data.image);
      return right(updateUser);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogOutModel>> logOut(
      {required String fcmToken}) async {
    Map<String, String> requestBody = {
      "fcm_token": fcmToken,
    };

    try {
      final response = await api.post(EndPonit.logout, data: requestBody);

      // تنظيف الكاش عند تسجيل الخروج
      await CacheHelper().removeData(key: ApiKey.token);
      await CacheHelper().removeData(key: ApiKey.id);
      await CacheHelper().removeData(key: ApiKey.name);
      await CacheHelper().removeData(key: ApiKey.email);
      await CacheHelper().removeData(key: ApiKey.phone);
      await CacheHelper().removeData(key: ApiKey.image);
      await CacheHelper().removeData(key: 'lang');
      final logOutModel = LogOutModel.fromJson(response);
      return right(logOutModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}

// import 'package:dartz/dartz.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shoping/cache/cache_helper.dart';

// import 'package:shoping/core/api/api_consumer.dart';
// import 'package:shoping/core/api/end_ponits.dart';
// import 'package:shoping/core/errors/exceptions.dart';
// import 'package:shoping/core/functions/upload_image_to_api.dart';

// import 'package:shoping/features/user/data/models/sign_in_model/sign_in_model.dart';
// import 'package:shoping/features/user/data/models/sign_up_model/sign_up_model.dart';
// import 'package:shoping/features/user/data/models/update_profile_model/update_profile_model.dart';
// import 'package:shoping/features/user/data/models/user_profile_model/user_profile_model.dart';
// import 'package:shoping/features/user/data/repos/user_repo.dart';

// class UserRepoImpl extends UserRepo {
//   final ApiConsumer api;

//   UserRepoImpl(this.api);

//   @override
//   Future<Either<String, UserProfileModel>> getUserProfile() async {
//     try {
//       // Check cache first
//       final cachedName = await CacheHelper().getData(key: ApiKey.name);
//       final cachedEmail = await CacheHelper().getData(key: ApiKey.email);
//       final cachedPhone = await CacheHelper().getData(key: ApiKey.phone);
//       final cachedImage = await CacheHelper().getData(key: ApiKey.image);

//       if (cachedName != null &&
//           cachedEmail != null &&
//           cachedPhone != null &&
//           cachedImage != null) {
//         final userProfile = UserProfileModel(
//           data: UserProfileData(
//             id: await CacheHelper().getData(key: ApiKey.id),
//             name: cachedName,
//             email: cachedEmail,
//             phone: cachedPhone,
//             image: cachedImage,
//           ),
//         );
//         return right(userProfile);
//       } else {
//         final response = await api.get(EndPonit.userProfile);
//         final userProfile = UserProfileModel.fromJson(response);
//         // Save data to cache
//         await CacheHelper()
//             .saveData(key: ApiKey.name, value: userProfile.data.name);
//         await CacheHelper()
//             .saveData(key: ApiKey.email, value: userProfile.data.email);
//         await CacheHelper()
//             .saveData(key: ApiKey.phone, value: userProfile.data.phone);
//         await CacheHelper()
//             .saveData(key: ApiKey.image, value: userProfile.data.image);
//         await CacheHelper()
//             .saveData(key: ApiKey.id, value: userProfile.data.id);
//         return right(userProfile);
//       }
//     } on ServerException catch (e) {
//       return left(e.errModel.errMessage);
//     }
//   }

//   @override
//   Future<Either<String, SignInModel>> signIn(
//       {required String email, required String password}) async {
//     try {
//       final response = await api.post(EndPonit.signIn, data: {
//         ApiKey.email: email,
//         ApiKey.password: password,
//       });
//       final user = SignInModel.fromJson(response);

//       CacheHelper().saveData(key: ApiKey.token, value: user.data!.token);
//       CacheHelper().saveData(key: ApiKey.id, value: user.data!.id);
//       return right(user);
//     } on ServerException catch (e) {
//       return left(e.errModel.errMessage);
//     }
//   }

//   @override
//   Future<Either<String, SignUpModel>> signUp(
//       {required String name,
//       required String email,
//       required String password,
//       required String phone,
//       required XFile image}) async {
//     try {
//       final response = await api.post(EndPonit.signUp, isFormData: true, data: {
//         ApiKey.name: name,
//         ApiKey.email: email,
//         ApiKey.password: password,
//         ApiKey.phone: phone,
//         ApiKey.image: await uploadImageToAPI(image)
//       });
//       final signUpmodel = SignUpModel.fromJson(response);
//       return right(signUpmodel);
//     } on ServerException catch (e) {
//       return left(e.errModel.errMessage);
//     }
//   }

//   @override
//   Future<Either<String, UpdateProfileModel>> updateUserProfile(
//       {required String name,
//       required String email,
//       required String phone}) async {
//     try {
//       final response = await api.put(EndPonit.updateProfile, data: {
//         ApiKey.name: name,
//         ApiKey.email: email,
//         ApiKey.phone: phone,
//       });
//       final updateUser = UpdateProfileModel.fromJson(response);
//       // Save updated data to cache
//       await CacheHelper()
//           .saveData(key: ApiKey.name, value: updateUser.data.name);
//       await CacheHelper()
//           .saveData(key: ApiKey.email, value: updateUser.data.email);
//       await CacheHelper()
//           .saveData(key: ApiKey.phone, value: updateUser.data.phone);
//       await CacheHelper()
//           .saveData(key: ApiKey.image, value: updateUser.data.image);
//       return right(updateUser);
//     } on ServerException catch (e) {
//       return left(e.errModel.errMessage);
//     }
//   }
// }
