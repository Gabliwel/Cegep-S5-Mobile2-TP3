import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/viewmodels/welcome_viewmodel.dart';
import 'package:tp3/views/about_view.dart';
import 'package:tp3/utils/constants.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (BuildContext context, viewModel, Widget? child) => Scaffold(
        appBar: AppBar(title: const Text(SITE_URL)),
        drawer: Drawer(
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(MENU_LABEL),
            ),
            ListTile(
              title: const Text(ABOUT_LABEL),
              onTap: () {
                Navigator.pop(context);
                viewModel.goToAbout();
              },
            ),
            ListTile(
              title: const Text(DISCONNECT),
              onTap: () {
                Navigator.pop(context);
                viewModel.disconnect();
              },
            ),
          ]),
        ),
        body: Center(
          child: Column(
            children: const [
              Text(
                WELCOME_TEXT,
                style: TextStyle(
                  height: 2, 
                  fontSize: 20
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        // pas le choix de mettre plus de un element, sinon flutter cause une erreur
        // cest pourquoi même si ils ne sont pas fonctionnels, les trois éléments sont présents
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: HOME,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.vertical_split_sharp),
              label: STATIONS,
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.blue,
          onTap: ((value) {
            //si stations
            if(value == 1) {
              viewModel.goToStations();
            }
          }),
        ),
      ),
    );
  }
}
