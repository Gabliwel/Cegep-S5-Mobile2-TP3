import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:http/http.dart' as http;
import 'package:tp3/services/api_service.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/views/login_view.dart';
import 'package:tp3/views/comments_view.dart';
import 'package:tp3/views/sign_up_view.dart';
import 'package:tp3/views/stations_view.dart';

// Pour le easy_location
// flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S ./assets/translations

// Pour stacked
// flutter pub run build_runner build --delete-conflicting-outputs

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: CommentsView),
    MaterialRoute(page: AllStationView)
  ],
  // Voir https://pub.dev/packages/stacked#dependency-registration
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: http.Client),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: AuthenticationService),
  ],
)
class App {
  /** Serves no purpose besides having an annotation attached to it */
}
