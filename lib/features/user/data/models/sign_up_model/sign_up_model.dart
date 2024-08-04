import 'package:shoping/core/api/end_ponits.dart';
import 'package:shoping/features/user/data/models/sign_in_model/data.dart';

class SignUpModel {
  final String? message;
  final Data? data;

  SignUpModel({required this.message, this.data});

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        message: json["message"] as String?,
        data: json[ApiKey.data] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );
  // (Map<String, dynamic> jsonData) {
  //   return SignUpModel(message: jsonData[ApiKey.message]);

  // }
  Map<String, dynamic> toJson() => {
        "message": message,
        'data': data?.toJson(),
      };
}
