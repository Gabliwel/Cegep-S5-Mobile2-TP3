// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;
import 'package:tp3/models/user.dart' as _i9;
import 'package:tp3/views/about_view.dart' as _i5;
import 'package:tp3/views/comments_view.dart' as _i6;
import 'package:tp3/views/login_view.dart' as _i2;
import 'package:tp3/views/sign_up_view.dart' as _i3;
import 'package:tp3/views/stations_view.dart' as _i7;
import 'package:tp3/views/welcome_view.dart' as _i4;

class Routes {
  static const loginView = '/';

  static const signUpView = '/sign-up-view';

  static const welcomeView = '/welcome-view';

  static const aboutView = '/about-view';

  static const commentsView = '/comments-view';

  static const allStationView = '/all-station-view';

  static const all = <String>{
    loginView,
    signUpView,
    welcomeView,
    aboutView,
    commentsView,
    allStationView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.loginView,
      page: _i2.LoginView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i3.SignUpView,
    ),
    _i1.RouteDef(
      Routes.welcomeView,
      page: _i4.WelcomeView,
    ),
    _i1.RouteDef(
      Routes.aboutView,
      page: _i5.AboutView,
    ),
    _i1.RouteDef(
      Routes.commentsView,
      page: _i6.CommentsView,
    ),
    _i1.RouteDef(
      Routes.allStationView,
      page: _i7.AllStationView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.LoginView(),
        settings: data,
      );
    },
    _i3.SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.SignUpView(),
        settings: data,
      );
    },
    _i4.WelcomeView: (data) {
      final args = data.getArgs<WelcomeViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i4.WelcomeView(key: args.key, user: args.user),
        settings: data,
      );
    },
    _i5.AboutView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.AboutView(),
        settings: data,
      );
    },
    _i6.CommentsView: (data) {
      final args = data.getArgs<CommentsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.CommentsView(key: args.key, slugName: args.slugName),
        settings: data,
      );
    },
    _i7.AllStationView: (data) {
      final args = data.getArgs<AllStationViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.AllStationView(key: args.key, title: args.title),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class WelcomeViewArguments {
  const WelcomeViewArguments({
    this.key,
    required this.user,
  });

  final _i8.Key? key;

  final _i9.User user;
}

class CommentsViewArguments {
  const CommentsViewArguments({
    this.key,
    required this.slugName,
  });

  final _i8.Key? key;

  final String slugName;
}

class AllStationViewArguments {
  const AllStationViewArguments({
    this.key,
    required this.title,
  });

  final _i8.Key? key;

  final String title;
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWelcomeView({
    _i8.Key? key,
    required _i9.User user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.welcomeView,
        arguments: WelcomeViewArguments(key: key, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAboutView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.aboutView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCommentsView({
    _i8.Key? key,
    required String slugName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.commentsView,
        arguments: CommentsViewArguments(key: key, slugName: slugName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllStationView({
    _i8.Key? key,
    required String title,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.allStationView,
        arguments: AllStationViewArguments(key: key, title: title),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
