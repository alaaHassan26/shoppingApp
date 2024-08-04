// update_profile_model.dart
class UpdateProfileModel {
  UpdateProfileModel({
    required this.data,
  });

  UpdateProfileData data;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        data: UpdateProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UpdateProfileData {
  UpdateProfileData({
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

  factory UpdateProfileData.fromJson(Map<String, dynamic> json) =>
      UpdateProfileData(
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
