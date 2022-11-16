import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/post.dart';
import 'package:tp3/services/api_service.dart';

class PostsViewModel extends BaseViewModel {
  final _api = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  List<Post> posts = [];

  Future getPosts(int userId) async {
    setBusy(true);
    try {
      posts = await _api.getPostsForUser(userId);
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
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
