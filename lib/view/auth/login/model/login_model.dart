
import 'package:dio/dio.dart';
import '../../../../core/base/model/base_request_model.dart';
import '../../../../core/base/model/base_response_model.dart';

class LoginRequestModel extends BaseRequestModel {
  late String email;
  late String password;
  LoginRequestModel({
    required this.email,
    required this.password,
  });
  LoginRequestModel.blank();

  @override
  Map<String, Object> toJson() {
    return {
      "email": email, 
      "password": password
    };
  }
}

class LoginResponseModel extends BaseResponseModel<LoginResponseModel> {
  late String jwtToken;
  late String jwtRefreshToken;
  LoginResponseModel({
    required this.jwtToken,
    required this.jwtRefreshToken,
  });

  LoginResponseModel.blank();

  @override
  LoginResponseModel fromResponse(Object jsonData, RequestOptions requestOptions) {
    jsonData = jsonData as Map<String,dynamic>;
    return LoginResponseModel(jwtToken: jsonData["jwt_token"], jwtRefreshToken: jsonData["refresh_token"]);
  }
}
