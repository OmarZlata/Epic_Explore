import 'package:epic_expolre/core/models/user_models/sign_up_model.dart';

class EndPoint {
  static String baseUrl = "https://tour-guide-api.onrender.com/";
  static String signIn = "api/user/login/";
  static String register = "api/user/register/";
  static String logout = "api/user/logout/";
  static String forgot_password = "api/user/forgot_password/";
  static String reset_password = "api/user/reset_pass/";
  static String GuiderSignIn = "api/guider/login";
  static String GuiderLogOut = "api/guider/logout";
  static String GuiderSignUp = "api/guider/register";
  static String SendGuiderReq (id){
    return "api/user/contact/contact_request/$id" ;
  }
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id" ;
  }
}

class ApiKey {
  static String success = 'success';
  static String img = "image";
  static String OtpPhone = "verification_code";
  static String description = "description";
  static String updatedAt = "updated_at";
  static String createdAt = "created_at";
  static String nationalId = "national_id";
  static String status = "status";
  static String errorMessage = "message";
  static String email = "email";
  static String password = "password";
  static String confirmNewPassword = "password_confirmation";
  static String newPassword = "password";
  static String token = "token";
  static String Guidertoken = "token";
  static String otp = "token";
  static String message = "message";
  static String UserMessage = "message";
  static String id = "id";
  static String GuiderId = "id";
  static String name = "name";
  static String phone = "phone";
  static String phoneNnumber = "phone_number";
  static String confirmPassword = "password_confirmation";

  static String isVerified = "is_verified";
  static String location = "location";
  static String profilePic = "profilePic";
  static String image = "image";
}
