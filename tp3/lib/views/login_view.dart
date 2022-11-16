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

  // https://medium.com/flutter-community/implementing-remember-me-functionality-in-flutter-using-local-storage-45184745a5b3#:~:text=The%20basic%20idea%20is%20when,put%20in%20the%20text%20field.
  // pour le remember me, a voir avant si une méthode que veux le prof

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, loginViewModel, child) => Scaffold(
        appBar: AppBar(title: const Text("Inscription"), automaticallyImplyLeading: false),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                Image.asset("assets/images/revolvair-logo.jpg"),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _loginController,
                  validator: (value) => Validators.validateEmail(value),
                  decoration: const InputDecoration(
                    labelText: "Courriel",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _loginController2,
                  validator: (value) => Validators.validatePassword(value),
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24)
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false
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
