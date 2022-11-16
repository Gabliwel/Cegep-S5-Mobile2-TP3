import 'package:flutter/material.dart';
import 'package:tp3/validators/validators.dart';
import 'package:tp3/viewmodels/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _loginController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, loginViewModel, child) => Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Image.asset("assets/images/revolvair-logo.jpg"),
                const SizedBox(height: 25),
                const Text("Connexion", style: TextStyle(fontSize: 22),),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _loginController,
                  validator: (value) => Validators.validateUser(value),
                  decoration: const InputDecoration(
                    labelText: "Courriel",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _loginController2,
                  validator: (value) => Validators.validateUser(value),
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24)
                  ),
                ),
                const SizedBox(height: 5),
                loginViewModel.isBusy
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text('Se connecter'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginViewModel.login(_loginController.text, _loginController2.text);
                        }
                      }
                    ),
                ElevatedButton(
                  child: const Text('Je n\'ai pas de compte'),
                  onPressed: () {
                    loginViewModel.signUp();
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
