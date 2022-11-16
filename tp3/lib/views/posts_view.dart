import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/viewmodels/posts_viewmodel.dart';
import 'package:tp3/widgets/post_item.dart';

class PostsView extends StatelessWidget {
  final int userId;

  const PostsView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostsViewModel>.reactive(
      viewModelBuilder: () => PostsViewModel(),
      onModelReady: (viewModel) => viewModel.getPosts(userId),
      builder: (BuildContext context, viewModel, Widget? child) => Scaffold(
        body: Center(
          child: viewModel.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.posts.length,
                    itemBuilder: (context, index) => PostItem(
                      post: viewModel.posts[index],
                      onTap: () => viewModel.navigateToPost(index),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
