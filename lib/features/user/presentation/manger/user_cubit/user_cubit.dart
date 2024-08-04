import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoping/core/utils/app_localiizations.dart';

import 'package:shoping/features/user/data/models/update_profile_model/update_profile_model.dart';
import 'package:shoping/features/user/data/models/user_profile_model/user_profile_model.dart';
import 'package:shoping/features/user/data/repos/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo, this.context) : super(UserInitial());

  final UserRepo userRepo;
  final BuildContext context;
  UserProfileModel? userProfile;

  //Profile Pic
  XFile? profilePic;
  String? profilePicError; // <-- إضافة متغير رسالة الخطأ

  //Form keys
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> updateProfileKey = GlobalKey();

  //Controllers
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController updateUpName = TextEditingController();
  TextEditingController updatePhoneNumber = TextEditingController();
  TextEditingController updateEmail = TextEditingController();

  // Error Messages
  String? emailError;
  String? passwordError;
  String? nameError;

  @override
  Future<void> close() {
    // Remove listeners when the cubit is closed
    signInEmail.removeListener(clearEmailError);
    signInPassword.removeListener(clearPasswordError);
    signUpName.removeListener(clearNameError);
    signUpEmail.removeListener(clearEmailError);
    signUpPassword.removeListener(clearPasswordError);
    return super.close();
  }

  void clearEmailError() {
    if (emailError != null) {
      emailError = null;
      emit(SignInFormError(emailError: null, passwordError: passwordError));
    }
  }

  void clearPasswordError() {
    if (passwordError != null) {
      passwordError = null;
      emit(SignInFormError(emailError: emailError, passwordError: null));
    }
  }

  void clearNameError() {
    if (nameError != null) {
      nameError = null;
      emit(SignUpFormError(
        nameError: null,
        emailError: emailError,
        passwordError: passwordError,
      ));
    }
  }

  void clearProfilePicError() {
    // <-- إضافة دالة لإزالة رسالة الخطأ للصورة
    if (profilePicError != null) {
      profilePicError = null;
      emit(ProfilePicErrorCleared());
    }
  }

  signIn() async {
    emailError = validateEmail(signInEmail.text);
    passwordError = validatePassword(signInPassword.text);
    if (emailError != null || passwordError != null) {
      emit(SignInFormError(
          emailError: emailError, passwordError: passwordError));
      return;
    }

    emit(SignInLoading());
    final response = await userRepo.signIn(
        email: signInEmail.text, password: signInPassword.text);
    response.fold(
        (failure) => emit(SignInFailure(errMessage: failure.errMessage)),
        (signInModel) => emit(SignInSuccess(message: signInModel.message!)));
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return AppLocalizations.of(context)!.translate('emailcannotbeempty');
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return AppLocalizations.of(context)!.translate('invalidemailaddress');
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return AppLocalizations.of(context)!.translate('passwordcannotbeempty');
    } else if (password.length < 8) {
      return AppLocalizations.of(context)!
          .translate('passwordmustbeatleast8characters');
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return AppLocalizations.of(context)!
          .translate('passwordmustcontainatleastoneuppercaseletterandonedigit');
    }
    return null;
  }

  String? validateName(String name) {
    if (name.isEmpty) {
      return AppLocalizations.of(context)!.translate('namecannotbeempty');
    } else if (name.length < 3) {
      return AppLocalizations.of(context)!
          .translate('namemustbeatleast3characters');
    }
    return null;
  }

  signUp() async {
    nameError = validateName(signUpName.text);
    emailError = validateEmail(signUpEmail.text);
    passwordError = validatePassword(signUpPassword.text);
    if (profilePic == null) {
      // <-- التحقق من اختيار الصورة
      profilePicError =
          AppLocalizations.of(context)!.translate('profilepiccannotbeempty');
      emit(SignUpFormError(
          nameError: nameError,
          emailError: emailError,
          passwordError: passwordError));
      return;
    }
    if (nameError != null || emailError != null || passwordError != null) {
      emit(SignUpFormError(
          nameError: nameError,
          emailError: emailError,
          passwordError: passwordError));
      return;
    }

    emit(SignUpLoading());
    final response = await userRepo.signUp(
      name: signUpName.text,
      email: signUpEmail.text,
      password: signUpPassword.text,
      phone: signUpPhoneNumber.text,
      image: profilePic!,
    );
    response.fold(
        (failure) => emit(SignUpFailure(errMessage: failure.errMessage)),
        (signUpModel) => emit(SignUpSuccess(message: signUpModel.message!)));
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    clearProfilePicError(); // <-- إزالة رسالة الخطأ عند تحميل الصورة
    emit(UploadProfilePic());
  }

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    final response = await userRepo.getUserProfile();
    response
        .fold((failure) => emit(ProfileFailure(errMessage: failure.errMessage)),
            (userProfileModel) {
      userProfile = userProfileModel;
      // Initialize text controllers with the loaded data
      updateUpName.text = userProfile!.data.name;
      updatePhoneNumber.text = userProfile!.data.phone;
      updateEmail.text = userProfile!.data.email;
      emit(ProfileSuccess(user: userProfileModel));
    });
  }

  Future<void> updateUserProfile() async {
    emit(UpdateProfileLoading());
    final response = await userRepo.updateUserProfile(
      name: updateUpName.text,
      email: updateEmail.text,
      phone: updatePhoneNumber.text,
    );
    response.fold(
      (failure) => emit(UpdateProfileFailure(errMessage: failure.errMessage)),
      (updateProfileModel) {
        userProfile = _convertUpdateProfileToUserProfile(updateProfileModel);
        emit(UpdateProfileSuccess(user: updateProfileModel));
      },
    );
  }

  UserProfileModel _convertUpdateProfileToUserProfile(
      UpdateProfileModel updateProfile) {
    return UserProfileModel(
      data: UserProfileData(
        id: updateProfile.data.id,
        name: updateProfile.data.name,
        email: updateProfile.data.email,
        phone: updateProfile.data.phone,
        image: updateProfile.data.image,
      ),
    );
  }

  Future<void> logout(String fcmToken) async {
    emit(LogoutLoading());
    final response = await userRepo.logOut(fcmToken: fcmToken);
    response.fold((failure) => emit(LogoutFailure(error: failure.errMessage)),
        (logoutModel) => emit(LogoutSuccess(message: logoutModel.message)));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
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

// part 'user_state.dart';

// class UserCubit extends Cubit<UserState> {
//   UserCubit(this.api) : super(UserInitial());
//   final ApiConsumer api;
//   //Profile Pic
//   XFile? profilePic;
//   //Sign in Form key
//   GlobalKey<FormState> signInFormKey = GlobalKey();
//   //Sign in email
//   TextEditingController signInEmail = TextEditingController();
//   //Sign in password
//   TextEditingController signInPassword = TextEditingController();
//   //Sign Up Form key
//   GlobalKey<FormState> signUpFormKey = GlobalKey();
//   //Sign up name
//   TextEditingController signUpName = TextEditingController();
//   //Sign up phone number
//   TextEditingController signUpPhoneNumber = TextEditingController();
//   //Sign up email
//   TextEditingController signUpEmail = TextEditingController();
//   //Sign up password
//   TextEditingController signUpPassword = TextEditingController();
//   // //Sign Up Form key Form key
//   GlobalKey<FormState> updateProfileKey = GlobalKey();
//   //update name
//   TextEditingController updateUpName = TextEditingController();
//   //updatephone number
//   TextEditingController updatePhoneNumber = TextEditingController();
//   //update email
//   TextEditingController updateEmail = TextEditingController();

//   SignInModel? user;
//   signIn() async {
//     try {
//       emit(SignInLoading());
//       final response = await api.post(EndPonit.signIn, data: {
//         ApiKey.email: signInEmail.text,
//         ApiKey.password: signInPassword.text,
//       });
//       user = SignInModel.fromJson(response);

//       CacheHelper().saveData(key: ApiKey.token, value: user!.data!.token);
//       CacheHelper().saveData(key: ApiKey.id, value: user!.data!.id);
//       emit(SignInSuccess());
//     } on ServerException catch (e) {
//       emit(SignInFailure(errMessage: e.errModel.errMessage));
//     }
//   }

//   signUp() async {
//     try {
//       emit(SignUpLoading());
//       final response = await api.post(EndPonit.signUp, isFormData: true, data: {
//         ApiKey.name: signUpName.text,
//         ApiKey.email: signUpEmail.text,
//         ApiKey.password: signUpPassword.text,
//         ApiKey.phone: signUpPhoneNumber.text,
//         ApiKey.image: await uploadImageToAPI(profilePic!)
//       });
//       final signUpmodel = SignUpModel.fromJson(response);
//       // print(response);
//       emit(SignUpSuccess(message: signUpmodel.message));
//     } on ServerException catch (e) {
//       // print('$e' + 'fuckyou');
//       emit(SignUpFailure(errMessage: e.errModel.errMessage));
//     }
//   }

//   uploadProfilePic(XFile image) {
//     profilePic = image;
//     emit(UploadProfilePic());
//   }

//   Future<void> getUserProfile() async {
//     try {
//       emit(ProfileLoading());
//       final response = await api.get(EndPonit.userProfile);
//       final userProfile = UserProfileModel.fromJson(response);
//       emit(ProfileSuccess(user: userProfile));
//     } on ServerException catch (e) {
//       emit(ProfileFailure(errMessage: e.errModel.errMessage));
//     }
//   }

//   updateProfile() async {
//     try {
//       emit(UpdateProfileLoading());
//       final response = await api.put(
//         EndPonit.updateProfile,
//         data: {
//           ApiKey.name: updateUpName.text,
//           ApiKey.email: updateEmail.text,
//           ApiKey.phone: updatePhoneNumber.text,
//         },
//       );
//       final updatedUser = UpdateProfileModel.fromJson(response);
//       emit(UpdateProfileSuccess(user: updatedUser));

//       // استدعاء getUserProfile بعد التحديث الناجح
//       await getUserProfile();
//     } on ServerException catch (e) {
//       emit(UpdateProfileFailure(errMessage: e.errModel.errMessage));
//     }
//   }

//   UserProfileModel? userProfile;
//   UserProfileModel _convertUpdateProfileToUserProfile(
//       UpdateProfileModel updateProfile) {
//     return UserProfileModel(
//       data: UserProfileData(
//         id: updateProfile.data.id,
//         name: updateProfile.data.name,
//         email: updateProfile.data.email,
//         phone: updateProfile.data.phone,
//         image: updateProfile.data.image,
//       ),
//     );
//   }
// }
