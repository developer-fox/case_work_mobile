

import 'package:flutter/material.dart';
import 'package:weather_app/components/dialog/login_invalid_informations_dialog.dart';

void showInvalidInformationsDialog(BuildContext context, String message) {
  showDialog(
    barrierColor: Colors.black26,
    barrierDismissible: false,
    context: context, 
    builder:(context) {
      return LoginInvalidInformationsDialog(message: message);
    },
  );
}


