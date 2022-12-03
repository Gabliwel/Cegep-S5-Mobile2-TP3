import 'package:flutter/material.dart';
import 'package:tp3/validators/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/viewmodels/sign_up_viewmodel.dart';
import 'package:tp3/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
      builder: (context, signUpViewModel, child) => Scaffold(
        appBar: AppBar(title: const Text(CONNECTION_LABEL),),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey("nameSignUpKey"),
                  controller: _loginController,
                  validator: (value) => Validators.validateBasicField(value),
                  decoration: const InputDecoration(
                    labelText: NAME_LABEL,
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey("emailSignUpKey"),
                  controller: _loginController2,
                  validator: (value) => Validators.validateEmail(value),
                  decoration: const InputDecoration(
                    labelText: EMAIL_LABEL,
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey("passwordSignUpKey"),
                  controller: _loginController3,
                  validator: (value) => Validators.validatePassword(value),
                  decoration: const InputDecoration(
                    labelText: PASSWORD_LABEL,
                    border: OutlineInputBorder(), 
                    contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18)
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false
                ),
                const SizedBox(height: 5),
                CheckboxListTile(
                  key: const ValueKey("termsAndConditionSignUpKey"),
                  value: _termsChecked,
                  title: const Text(TERMS_AND_CONDITION_ACCEPT),
                  onChanged: (newValue) {
                    setState(() {
                      _termsChecked = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  subtitle: !_termsChecked && _showErrorTerms
                    ? const Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0), 
                      child: Text(OBLIGATORY, style: TextStyle(color: Color(0xFFe53935), fontSize: 12),),
                    )
                    : null,
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse("https://staging.revolvair.org/assets/tos.html"));
                    //signUpViewModel.launchURL();
                  },
                  child: const Text("Voir les conditions", style: TextStyle(color: Colors.blue),),
                ),
                const SizedBox(height: 5),
                signUpViewModel.isBusy
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      key: const ValueKey("createAccountButton"),
                      child: const Text(CREATE_ACCOUNT_LABEL),
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
