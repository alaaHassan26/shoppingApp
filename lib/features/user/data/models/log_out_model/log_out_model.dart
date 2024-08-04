import 'package:shoping/core/api/end_ponits.dart';

class LogOutModel {
  final String message;

  LogOutModel({required this.message});
  factory LogOutModel.fromJson(Map<String, dynamic> jsonData) {
    return LogOutModel(message: jsonData[ApiKey.message]);
  }
}
