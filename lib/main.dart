import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/components/entity/turkey_cities.dart';
import 'package:weather_app/core/constants/app/app_constants.dart';
import 'package:weather_app/core/constants/enums/locale_keys_enum.dart';
import 'package:weather_app/core/init/language/language_manager.dart';
import 'package:weather_app/core/init/navigation/navigation_route.dart';
import 'package:weather_app/core/init/navigation/navigation_service.dart';
import 'package:weather_app/core/init/network/connectivity/connectivity_bloc.dart';
import 'package:weather_app/core/init/theme/app_theme_light.dart';
import 'package:weather_app/view/auth/login/view/login_view.dart';
import 'package:weather_app/view/auth/login/viewmodel/bloc/login_view_model_bloc.dart';
import 'package:weather_app/view/auth/signup/viewmodel/bloc/signup_view_model_bloc.dart';
import 'package:weather_app/view/create_activity/viewmodel/bloc/create_activity_vm_bloc.dart';
import 'package:weather_app/view/home/view/home_view.dart';
import 'core/init/cache/locale_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // initialize the locale repository connection
  await LocaleManager.preferencesInit();
  // load the data of turkish cities
  await CitiesOfTurkey.loadEntities();
  // load environment variables
  await dotenv.load(fileName: ".env");
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      fallbackLocale:  LanguageManager.instance.enLocale,
      path: ApplicationConstants.LANG_ASSET_PATH,
      startLocale: LanguageManager.instance.trLocale,
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ConnectivityBloc()),
        BlocProvider(create: (context)=> LoginViewModelBloc()),
        BlocProvider(create: (context)=> SignupViewModelBloc()),
        BlocProvider(create: (context)=> CreateActivityVmBloc(initialState: CreateActivityVmState(currentFeedbackType: null, continuButtonOnPressed: null))),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          theme: AppThemeLight.instance.theme,
          home: LocaleManager.instance.getStringValue(PreferencesKeys.x_access_key) == "" ? const LoginView(): const HomeView(),
          onGenerateRoute: NavigationRoute.instance.generateRoute,
          navigatorKey: NavigationService.instance.navigatorKey,
      ),
    );
  }
}