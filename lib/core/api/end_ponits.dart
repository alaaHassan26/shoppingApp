class EndPonit {
  static String baseUrl = 'https://student.valuxapps.com/api/';
  static String signUp = 'register';
  static String signIn = 'login';
  static String userProfile = 'profile';
  static String updateProfile = 'update-profile';
  static String logout = 'logout';
  static String categoriesimage = 'categories';
  static String verifyEmail = 'verify-email';
  static String verifyCode = 'verify-code';
  static String categories(int num) {
    return 'categories/$num';
  }

  static String favorites = 'favorites';
}

class ApiKey {
  static String status = 'status';
  static String errMessage = 'message';
  static String message = 'message';
  static String name = 'name';
  static String email = 'email';
  static String phone = 'phone';
  static String password = 'password';
  static String token = 'token';
  static String id = 'id';
  static String data = 'data';
  static String image = 'image';
  static String price = 'price';
  static String discount = 'discount';
  static String code = 'code';
}
