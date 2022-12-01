import 'package:flutter/material.dart';
import 'package:tp3/validators/validators.dart';
import 'package:tp3/viewmodels/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/utils/constants.dart';

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
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (viewModel) => viewModel.rememberMeLogin(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, loginViewModel, child) => Scaffold(
        appBar: AppBar(title: const Text(CONNEXION), automaticallyImplyLeading: false),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                loginViewModel.rememberMeLoginAction
                  ? const CircularProgressIndicator()
                  : Column(children: [
                Image.asset(REVOLVAIR_LOGO_PATH),
                const SizedBox(height: 25),
                TextFormField(
                  key: const ValueKey('emailSignInField'),
                  controller: _loginController,
                  validator: (value) => Validators.validateEmail(value),
                  decoration: const InputDecoration(
                    labelText: MAIL_LABEL,
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(12, 24, 12, 24)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('passwordSignInField'),
                  controller: _loginController2,
                  validator: (value) => Validators.validatePassword(value),
                  decoration: const InputDecoration(
                    labelText: PASSWORD_LABEL,
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
                    key: const ValueKey("connectButton"),
                      child: const Text(CONNECT),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginViewModel.login(_loginController.text, _loginController2.text);
                        }
                      }
                    ),
                ElevatedButton(
                  key: const ValueKey("noAccountButton"),
                  child: const Text(NO_ACCOUNT_LABEL),
                  onPressed: () {
                    loginViewModel.signUp();
                  }
                )
              ])],
            ),
          ),
        ),
      ),
    );
  }
}
