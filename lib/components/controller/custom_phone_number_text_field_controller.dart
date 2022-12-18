

import 'package:flutter/material.dart';

class CustomPhoneNumberTextFieldController extends ChangeNotifier {
  RegExp validator = RegExp("^(?:[+0]9)?[0-9]{10}\$");
  
  final Map<String, String> fullValue = {"country_code": "", "phone_number": ""};

  void setFullValue({String? countryCode, String? phoneNumber}){
    fullValue["country_code"] = countryCode ?? fullValue["country_code"]!; 
    fullValue["phone_number"] = phoneNumber ?? fullValue["phone_number"]!;
    notifyListeners();
  }


  String? get getFullValue => fullValue["country_code"]! + fullValue["phone_number"]!;
  String? get phoneNumber => fullValue["phone_number"]!;
  String? get countryCode => fullValue["country_code"]!;

  bool get isValidPhoneNumber => validator.hasMatch(phoneNumber!);

}
