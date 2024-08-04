import 'package:shoping/core/api/end_ponits.dart';

import 'data.dart';

class SignInModel {
  final bool? status;
  final String? message;
  final Data? data;

  SignInModel({this.status, this.message, this.data});

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        status: json[ApiKey.status] as bool?,
        message: json["message"] as String?,
        data: json[ApiKey.data] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        ApiKey.status: status,
        "message": message,
        'data': data?.toJson(),
      };
}
