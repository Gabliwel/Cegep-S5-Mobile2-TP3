import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/comment.dart';
import 'package:tp3/services/api_service.dart';

class CommentsViewModel extends BaseViewModel {
  final _api = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  List<Comment> comments = [];

  Future getComments(String slugName) async {
    setBusy(true);
    try {
      print("Reach");
      print( await _api.getCommentsForSlug(slugName));
      comments = await _api.getCommentsForSlug(slugName);
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
      print(LocaleKeys.app_error);
    } finally {
      setBusy(false);
    }
  }

  navigateToPost(int index) {
    /*_navigationService.navigateTo(
      Routes.postCommentsView,
      arguments: PostCommentsViewArguments(post: posts[index]),
    );*/
  }
}
