import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoping/core/errors/failure.dart';
import 'package:shoping/features/user/data/models/log_out_model/log_out_model.dart';

import 'package:shoping/features/user/data/models/sign_in_model/sign_in_model.dart';
import 'package:shoping/features/user/data/models/sign_up_model/sign_up_model.dart';
import 'package:shoping/features/user/data/models/update_profile_model/update_profile_model.dart';

import 'package:shoping/features/user/data/models/user_profile_model/user_profile_model.dart';

abstract class UserRepo {
  Future<Either<Failure, SignInModel>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, SignUpModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required XFile image,
  });
  Future<Either<Failure, UserProfileModel>> getUserProfile();
  Future<Either<Failure, UpdateProfileModel>> updateUserProfile({
    required String name,
    required String email,
    required String phone,
  });
  Future<Either<Failure, LogOutModel>> logOut({required String fcmToken});
}

// abstract class UserRepo {
//   Future<Either<String, SignInModel>> signIn(
//       {required String email, required String password});
//   Future<Either<String, SignUpModel>> signUp(
//       {required String name,
//       required String email,
//       required String password,
//       required String phone,
//       required XFile image});

//   Future<Either<String, UserProfileModel>> getUserProfile();
// }
