import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/comment.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/viewmodels/comments_viewmodel.dart';

import 'comments_viewmodel_test.mocks.dart';


@GenerateMocks([NavigationService, DialogService, ApiService, Comment])
void main() {
  final _mockNavigationService = MockNavigationService();
  final _mockDialogService = MockDialogService();
  final _mockApiService = MockApiService();

  locator.registerSingleton<NavigationService>(_mockNavigationService);
  locator.registerSingleton<DialogService>(_mockDialogService);
  locator.registerSingleton<ApiService>(_mockApiService);

  tearDown(() {
    reset(_mockNavigationService);
    reset(_mockDialogService);
    reset(_mockApiService);
  });
  
  group("CommentsViewModel - getComments", () { 
    test("Si on obtient les commentaires sans erreurs, affiche aucun message d'erreur", () async {
      List<MockComment> comments = [MockComment()];
      when(_mockApiService.getCommentsForSlug("slugName")).thenAnswer((_) => Future.value(comments));

      final viewModel = CommentsViewModel();
      await viewModel.getComments("slugName");

      expect(comments.length, viewModel.comments.length);
    });

    test("Si on obtient les commentaires avec erreurs, affiche le message d'erreur", () async {
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      when(_mockApiService.getCommentsForSlug("slugName")).thenThrow(Error());

      final viewModel = CommentsViewModel();
      await viewModel.getComments("slugName");

      expect(viewModel.comments.isEmpty, true);
      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.app_error)))
          .called(1);
    });
  });

  group("CommentsViewModel - goToAddComment", () { 
    test("On peut aller a la page d'ajout de commentaire, et ensuite, recherche les commentaire une fois de retour sur la page", () async {
      when(_mockNavigationService.navigateTo(any,
              arguments: anyNamed(
                  'arguments'))) 
      .thenAnswer((_) => Future.value());

      //message afficher au retour dans la methode getComments(String slugName)
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());

      final viewModel = CommentsViewModel();
      
      await viewModel.goToAddComment("slugName");

      verify(_mockNavigationService.navigateTo(
              Routes.addCommentView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as AddCommentViewArguments;
    });
  });
}