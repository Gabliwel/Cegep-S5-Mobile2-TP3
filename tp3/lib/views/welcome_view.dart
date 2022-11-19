import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/viewmodels/welcome_viewmodel.dart';
import 'package:tp3/views/about_view.dart';

class WelcomeView extends StatelessWidget {
  final User user;
  const WelcomeView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (BuildContext context, viewModel, Widget? child) => Scaffold(
        appBar: AppBar(title: const Text("RevolvAir.org")),
        drawer: Drawer(
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                viewModel.goToAbout();
              },
            ),
            ListTile(
              title: const Text('Se déconnecter'),
              onTap: () {
                Navigator.pop(context);
                viewModel.disconnect();
              },
            ),
          ]),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Bonjour ${user.username}!',
                style: const TextStyle(
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
            icon: Icon(Icons.vertical_split_sharp),
            label: 'Stations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Mes notifications'
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue
      ),
      ),
    );
  }
}
