import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:tp3/models/station.dart';
import 'package:tp3/viewmodels/station_details_viewmodel.dart';
import 'package:tp3/viewmodels/station_viewmodel.dart';
import 'package:tp3/views/comments_view.dart';
import 'package:tp3/widgets/search_bar_widget.dart';

class StationDetailsView extends StatelessWidget {
 const StationDetailsView({super.key, required this.stationInfo});
 final Station stationInfo;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StationDetailsViewModel>.reactive(
      viewModelBuilder: () => StationDetailsViewModel(),
      onModelReady: (viewModel) => viewModel.getPM25MonthAverage(stationInfo.slugName), 
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
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
        body : viewModel.isBusy
        ? const Center(child: CircularProgressIndicator()) :
        Container(
          alignment: Alignment.center,
          child:
        Column(           
          children : <Widget>[ 
            Text("Station name : ${stationInfo.name}"),
            Text("Station slug name : ${stationInfo.slugName}"),
            Text("Station slug ID : ${stationInfo.slugID}"),
            Text("Station description : ${stationInfo.description}"),
            Text("Station comment number : ${stationInfo.commentNumber}"),
            Text("Station last PM25 measure : ${viewModel.pm25Average}"),
              ],
            )
          ),
          floatingActionButton: 
            FloatingActionButton(
        child: const Icon(Icons.comment),
          onPressed: () async {
            viewModel.sendToCommentPage(stationInfo.slugName);
  }),
          bottomNavigationBar: BottomNavigationBar(
        // pas le choix de mettre plus de un element, sinon flutter cause une erreur
        // cest pourquoi même si ils ne sont pas fonctionnels, les trois éléments sont présents
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.vertical_split_sharp),
              label: 'Stations',
            ),
          ],
          currentIndex: 1,
          selectedItemColor: Colors.blue,
          onTap: ((value) {
            //si stations
            if(value == 0) {
              viewModel.goToWelcome();
            }
          }),
        ))
      );
  }
}
