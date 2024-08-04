import 'package:shoping/core/api/end_ponits.dart';

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json[ApiKey.id] as int?,
        name: json[ApiKey.name] as String?,
        email: json[ApiKey.email] as String?,
        phone: json[ApiKey.phone] as String?,
        image: json['image'] as String?,
        points: json['points'] as int?,
        credit: json['credit'] as int?,
        token: json[ApiKey.token] as String?,
      );

  Map<String, dynamic> toJson() => {
        ApiKey.id: id,
        ApiKey.name: name,
        ApiKey.email: email,
        ApiKey.phone: phone,
        'image': image,
        'points': points,
        'credit': credit,
        ApiKey.token: token,
      };
  String? get idAsString => id?.toString();
}
