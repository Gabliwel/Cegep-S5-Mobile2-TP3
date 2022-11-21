import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/viewmodels/about_viewmodel.dart';
import 'package:tp3/utils/constants.dart';

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
              Text(DEVELOPPED_FOR),
              Text(SCHOOL_NAME),
              SizedBox(height: 15,),
              Text(SCHOOL_NAME),
              Text(SESSION_ID),
              SizedBox(height: 15,),
              Text(DEVELOPPED_BY),
              Text(DEVS_NAME)
            ],
          ),
        )  
      ),
    );
  }
}
