import 'package:shoping/core/api/end_ponits.dart';

class CategoriesModel {
  int? id;
  String? name;
  String? image;

  CategoriesModel({this.id, this.name, this.image});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json[ApiKey.image] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        ApiKey.image: image,
      };
}
