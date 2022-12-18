import 'package:easy_localization/easy_localization.dart';
import '../constants/app/app_constants.dart';

extension StringLocalization on String {
  /// Returns the value of the entered string according to the selected language pack or current location.
  String get locale => this.tr();
  /// Returns whether the entered string value is an email.
  bool get isValidEmails => RegExp(ApplicationConstants.EMAIL_REGEX).hasMatch(this);
}
