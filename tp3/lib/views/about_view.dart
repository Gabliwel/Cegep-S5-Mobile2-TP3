import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/viewmodels/about_viewmodel.dart';
import 'package:tp3/viewmodels/welcome_viewmodel.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutViewModel>.reactive(
      viewModelBuilder: () => AboutViewModel(),
      builder: (BuildContext context, viewModel, Widget? child) => Scaffold(
        appBar: AppBar(title: const Text("À propos")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(height: 10,),
              Text("Application développée dans le cadre du cours"),
              Text("420-50-SF - Développement mobile et objets connectés"),
              SizedBox(height: 15,),
              Text("Cégep de Sainte-Foy"),
              Text("Automne 2022"),
              SizedBox(height: 15,),
              Text("Application mobile développée par"),
              Text("Gabriel Bertrand et Keven Champagne")
            ],
          ),
        )  
      ),
    );
  }
}
