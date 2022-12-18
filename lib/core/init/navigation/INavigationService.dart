
import "navigation_service.dart";
import "package:flutter/material.dart";

/// interface for [NavigationService]
abstract class INavigationService {
  /// [navigateToPage] reversibly takes you to the given root. looks like this --> [Navigator.push]
  Future<void> navigateToPage({String? path, Object? data});
  ///[navigateToPageClear] irreversibly takes you to the given root. looks like this --> [Navigator.pushReplacement]
  Future<void> navigateToPageClear({String? path, Object? data});
}