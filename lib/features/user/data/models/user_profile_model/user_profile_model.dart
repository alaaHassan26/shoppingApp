// user_profile_model.dart
class UserProfileModel {
  UserProfileModel({
    required this.data,
  });

  UserProfileData data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        data: UserProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserProfileData {
  UserProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  int id;
  String name;
  String email;
  String phone;
  String image;

  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      UserProfileData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
      };
}
