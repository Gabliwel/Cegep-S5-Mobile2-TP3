import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/viewmodels/comments_viewmodel.dart';
import 'package:tp3/widgets/post_item.dart';

class CommentsView extends StatelessWidget {
  final String slugName;

  const CommentsView({Key? key, required this.slugName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentsViewModel>.reactive(
      viewModelBuilder: () => CommentsViewModel(),
      onModelReady: (viewModel) => viewModel.getComments(slugName),
      builder: (BuildContext context, viewModel, Widget? child) => Scaffold(
        body: Center(
          child: /* viewModel.isBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.comments.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => viewModel.navigateToPost(index),
                    ),
                  ),
                ), */
                Text("Test"),
        ),
      ),
    );
  }
}
