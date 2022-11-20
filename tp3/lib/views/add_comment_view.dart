import 'package:flutter/material.dart';
import 'package:tp3/validators/validators.dart';
import 'package:tp3/viewmodels/add_comment_viewmodel.dart';
import 'package:tp3/viewmodels/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddCommentView extends StatefulWidget {
  final String slugName;

  const AddCommentView({Key? key, required this.slugName}) : super(key: key);

  @override
  _AddCommentView createState() => _AddCommentView();
}

class _AddCommentView extends State<AddCommentView> {
  final TextEditingController _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCommentModel>.reactive(
      viewModelBuilder: () => AddCommentModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(title: const Text("Ajouter un commentaire")),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 15),
                TextFormField(
                  controller: _commentController,
                  validator: (value) => Validators.validateBasicField(value),
                  decoration: const InputDecoration(
                    labelText: "Commentaire",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24)
                  ),
                ),
                const SizedBox(height: 5),
                viewModel.isBusy
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text('Ajouter'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await viewModel.addComment(_commentController.text, widget.slugName);
                          if(success) {
                            //on retire le texte seulement avec succès
                            _commentController.text = "";
                          }
                        }
                      }
                    ),
              ]
              ),
            ),
          ),
        ),
      );
    
  }
}
