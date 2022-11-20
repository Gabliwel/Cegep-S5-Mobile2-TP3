import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/comment.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/views/add_comment_view.dart';

class CommentsViewModel extends BaseViewModel {
  final _api = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  List<Comment> comments = [];
  String _slugName = "";

  Future getComments(String slugName) async {
    setBusy(true);
    _slugName = slugName;
    try {
      comments = await _api.getCommentsForSlug(slugName);
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }
  
  goToAddComment(String slug) {
    _navigationService.navigateTo(
      Routes.addCommentView,
      arguments: AddCommentViewArguments(slugName: slug),
    )?.then((value) => getComments(_slugName));
  }
}
