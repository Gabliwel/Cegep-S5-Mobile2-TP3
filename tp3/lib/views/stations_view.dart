import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:tp3/models/station.dart';
import 'package:tp3/utils/constants.dart';
import 'package:tp3/viewmodels/station_viewmodel.dart';
import 'package:tp3/views/comments_view.dart';
import 'package:tp3/widgets/search_bar_widget.dart';

class AllStationView extends StatefulWidget {
  const AllStationView({super.key});

  @override
  State<AllStationView> createState() => _AllStationViewState();
}

class _AllStationViewState extends State<AllStationView> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StationsViewModel>.reactive(
      viewModelBuilder: () => StationsViewModel(),
      onModelReady: (viewModel) => viewModel.fetchAllStation(), 
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text(STATIONS_LABEL),
          actions: [
            IconButton(
              onPressed: (){
                showSearch(
                  context: context, delegate: SearchBar(searchList: viewModel.stations, stationViewModel: viewModel));
          }, icon: const Icon(Icons.search))],
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
        body : viewModel.isBusy
        ? const Center(child: CircularProgressIndicator()) :
        Center( 
          child: ListView.builder(
            itemCount: viewModel.stations.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                // Mettre un ID 
                key: ValueKey<int>(( viewModel.stations.elementAt(index).slugID)),
                child: Card(
                  child: ListTile(
                    title: Text("${ viewModel.stations.elementAt(index).slugID} - ${ viewModel.stations.elementAt(index).name}"),
                    subtitle: ( viewModel.stations.elementAt(index).description != null) ? 
                    Text('${ viewModel.stations.elementAt(index).description}'): null
                  ),
                ),
                onTap: () async {  
                  viewModel.sendToDetailPage(viewModel.stations.elementAt(index));
                }
              );
            }
          )
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
          currentIndex: 1,
          selectedItemColor: Colors.blue,
          onTap: ((value) {
            //si stations
            if(value == 0) {
              viewModel.goToWelcome();
            }
          }),
        )
      ),
    );
  }
}
