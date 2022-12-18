
import 'package:dio/dio.dart';

import '../../../../core/base/model/base_request_model.dart';
import '../../../../core/base/model/base_response_model.dart';

class SignupResponseModel extends BaseResponseModel<SignupResponseModel> {
  late String jwtToken;
  late String jwtRefreshToken;

  SignupResponseModel({
    required this.jwtToken,
    required this.jwtRefreshToken,
  });

  SignupResponseModel.blank();

  @override
  SignupResponseModel fromResponse(Object jsonData, RequestOptions requestOptions) {
    jsonData = jsonData as Map<String,dynamic>;
    return SignupResponseModel(jwtToken: jsonData["tokens"]["jwt_token"], jwtRefreshToken: jsonData["tokens"]["refresh_token"]);
  }
}

class SignupRequestModel extends BaseRequestModel {
  late String email;
  late String password;

  SignupRequestModel({
    required this.email,
    required this.password,
  });

  SignupRequestModel.blank();

  @override
  Object toJson() {
    return {
      "email": email,
      "password": password
    };
  }
}
