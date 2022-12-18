
import 'package:flutter/material.dart';
import 'INavigationService.dart';

/// The [NavigationService] class makes navigation operations more efficient and manageable over a single instance.
class NavigationService implements INavigationService {
  static NavigationService? _instance = NavigationService._init();
  static NavigationService get instance {
    _instance ??= NavigationService._init();
    return _instance!;
  }

  NavigationService._init();
  // navigatorKey for navigation actions
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Future<void> navigateToPage({String? path, Object? data}) async{
    path ??= "";
    await navigatorKey.currentState?.pushNamed(path, arguments: data);
  }
  
  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async{
    path ??= "";
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(path, arguments: data,(route) => false);
  }
}