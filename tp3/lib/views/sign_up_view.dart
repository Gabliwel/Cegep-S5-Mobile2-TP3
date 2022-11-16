import 'package:flutter/material.dart';
import 'package:tp3/validators/validators.dart';
import 'package:tp3/viewmodels/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/viewmodels/sign_up_viewmodel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _loginController2 = TextEditingController();
  final TextEditingController _loginController3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, signUpViewModel, child) => Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Image.asset("assets/images/revolvair-logo.jpg"),
                const SizedBox(height: 25),
                const Text("Inscription", style: TextStyle(fontSize: 22),),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _loginController,
                  validator: (value) => Validators.validateUser(value),
                  decoration: const InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _loginController2,
                  validator: (value) => Validators.validateUser(value),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _loginController3,
                  validator: (value) => Validators.validateUser(value),
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                ),
                const SizedBox(height: 5),
                signUpViewModel.isBusy
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text('Créer le compte'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUpViewModel.signUp(_loginController.text, _loginController2.text, _loginController3.text);
                        }
                      }
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
