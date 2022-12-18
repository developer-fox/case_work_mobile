
import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/navigation/navigation_constants.dart';
import 'package:weather_app/view/auth/login/view/login_view.dart';
import 'package:weather_app/view/auth/signup/view/signup_view.dart';
import 'package:weather_app/view/create_activity/model/create_activity_view_dependency_model.dart';
import 'package:weather_app/view/create_activity/view/create_activity_view.dart';
import 'package:weather_app/view/home/view/home_view.dart';
import 'package:weather_app/view/weather_of_week/view/weather_of_week_view.dart';

/// The [NavigationRoute] class makes navigation operations more efficient and manageable over a single instance.
class NavigationRoute {
  static NavigationRoute? _instance = NavigationRoute._init();
  static NavigationRoute get instance {
    _instance ??= NavigationRoute._init();
    return _instance!;
  }

  NavigationRoute._init();
  //
  /// This is how routes to be followed according to the route statics in [NavigationConstants] are defined in [generateRoute].
  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.SIGNUP_VIEW:
      return normalNavigate(const SignupView());
      case NavigationConstants.HOME_VIEW:
      return normalNavigate(const HomeView());
      case NavigationConstants.LOGIN_VIEW:
      return normalNavigate(const LoginView());
      case NavigationConstants.CREATE_ACTIVITY_VIEW:
      return normalNavigate(CreateActivityView(dependencyModel: args.arguments as CreateActivityViewDependencyModel?,));
      case NavigationConstants.WEATHER_OF_WEEK_VIEW:
      return normalNavigate(WeatherOfWeekView(activityId: args.arguments as String));
      default:
        return normalNavigate(emptyScaffold);
    }
  }
}

Scaffold get emptyScaffold {
  return const Scaffold(
    body: Center(
      child: Text("core: navigation route default case"),
    ),
  );
}

MaterialPageRoute normalNavigate(Widget widget) {
  return MaterialPageRoute(builder: ((context) => widget));
}