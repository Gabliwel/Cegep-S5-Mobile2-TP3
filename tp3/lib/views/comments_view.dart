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
    builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text("Comments for $slugName"),
          backgroundColor: Colors.black,
        ),
        body : 
        viewModel.comments.isNotEmpty ?
        Center( 
          child: ListView.builder(
            itemCount: viewModel.comments.length,
            itemBuilder: (context, int index){
              return GestureDetector(
                // Mettre un ID 
                  key: ValueKey<int>(( viewModel.comments.elementAt(index).id)),
                  child: Card(
                    child: ListTile(
                      title: Text("${viewModel.comments.elementAt(index).id} - ${ viewModel.comments.elementAt(index).userName}"),
                      subtitle: Text( viewModel.comments.elementAt(index).body) 
                    ),
                  ),
              );
            }))
            : const Center(
              child: Text("This slug has no comments"))),
      );
  }
}
