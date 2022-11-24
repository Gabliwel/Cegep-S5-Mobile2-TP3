import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/viewmodels/comments_viewmodel.dart';
import 'package:tp3/widgets/custom_comment_list_tile.dart';
import 'package:tp3/utils/constants.dart';

class CommentsView extends StatelessWidget {
  final String slugName;

  const CommentsView({Key? key, required this.slugName}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentsViewModel>.reactive(
      viewModelBuilder: () => CommentsViewModel(),
      onModelReady: (viewModel) => viewModel.getComments(slugName), 
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text("$COMMENT_FOR $slugName"),
          backgroundColor: Colors.blue,
        ),
        body : 
          viewModel.isBusy
          ? const Center(child: CircularProgressIndicator()) :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              viewModel.comments.isNotEmpty
              ? Expanded(child: 
                ListView.builder(
                  itemCount: viewModel.comments.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      key: ValueKey<int>(( viewModel.comments.elementAt(index).id)),
                      child: CustomCommentListItem(userName:viewModel.comments.elementAt(index).userName, body: viewModel.comments.elementAt(index).body, postedTime: viewModel.comments.elementAt(index).createdTime ),
                    );
                  }
                )
              ): 
              const Expanded(
                child: Center(child: Text(NO_COMMENT))
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      onPressed: () => viewModel.goToAddComment(slugName),
                      child: const Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ]
              )
            ]
          )
      ),
    );
  }
}
