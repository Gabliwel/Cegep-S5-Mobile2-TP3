// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:http/src/client.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';

import '../services/api_service.dart';
import '../services/authentication_service.dart';
import '../utils/shared_preferences_util.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => Client());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => SharedPreferencesUtils());
}
