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
  
  bool _termsChecked = false;
  bool _showErrorTerms = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, signUpViewModel, child) => Scaffold(
        appBar: AppBar(title: const Text("Inscription"),),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 25),
                TextFormField(
                  controller: _loginController,
                  validator: (value) => Validators.validateBasicField(value),
                  decoration: const InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _loginController2,
                  validator: (value) => Validators.validateEmail(value),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _loginController3,
                  validator: (value) => Validators.validatePassword(value),
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false
                ),
                const SizedBox(height: 5),
                CheckboxListTile(
                  value: _termsChecked,
                  title: const Text("J'accepte les termes et conditions."),
                  onChanged: (newValue) {
                    setState(() {
                      _termsChecked = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  subtitle: !_termsChecked && _showErrorTerms
                    ? const Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0), 
                      child: Text('Obligatoire', style: TextStyle(color: Color(0xFFe53935), fontSize: 12),),
                    )
                    : null,
                ),
                signUpViewModel.isBusy
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text('Créer le compte'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if(!_termsChecked) {
                            setState(() => _showErrorTerms = true);
                          } else {
                            setState(() => _showErrorTerms = false);
                            signUpViewModel.signUp(_loginController.text, _loginController2.text, _loginController3.text);
                          }
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
