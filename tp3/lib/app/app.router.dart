// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i9;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;
import 'package:tp3/views/about_view.dart' as _i5;
import 'package:tp3/views/add_comment_view.dart' as _i8;
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

  static const addCommentView = '/add-comment-view';

  static const all = <String>{
    loginView,
    signUpView,
    welcomeView,
    aboutView,
    commentsView,
    allStationView,
    addCommentView,
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
    _i1.RouteDef(
      Routes.addCommentView,
      page: _i8.AddCommentView,
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
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.WelcomeView(),
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
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.AllStationView(),
        settings: data,
      );
    },
    _i8.AddCommentView: (data) {
      final args = data.getArgs<AddCommentViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.AddCommentView(key: args.key, slugName: args.slugName),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class CommentsViewArguments {
  const CommentsViewArguments({
    this.key,
    required this.slugName,
  });

  final _i9.Key? key;

  final String slugName;
}

class AddCommentViewArguments {
  const AddCommentViewArguments({
    this.key,
    required this.slugName,
  });

  final _i9.Key? key;

  final String slugName;
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

  Future<dynamic> navigateToWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.welcomeView,
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
    _i9.Key? key,
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

  Future<dynamic> navigateToAllStationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allStationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddCommentView({
    _i9.Key? key,
    required String slugName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addCommentView,
        arguments: AddCommentViewArguments(key: key, slugName: slugName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
