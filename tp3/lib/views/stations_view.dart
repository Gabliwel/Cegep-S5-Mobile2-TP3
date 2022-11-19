import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:tp3/models/station.dart';
import 'package:tp3/viewmodels/station_viewmodel.dart';
import 'package:tp3/views/comments_view.dart';

class AllStationView extends StatefulWidget {
  const AllStationView({super.key, required this.title});

  final String title;

  @override
  State<AllStationView> createState() => _AllStationViewState();
}

class _AllStationViewState extends State<AllStationView> {

  @override
  void initState() {
    super.initState();
/*     Timer(Duration(seconds: 1), () => setState(() {
      
    })); */
  }  


  @override
  Widget build(BuildContext context) {
   return ViewModelBuilder<StationsViewModel>.reactive(
    viewModelBuilder: () => StationsViewModel(),
    onModelReady: (viewModel) => viewModel.fetchAllStation(), 
    builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Stations"),
          backgroundColor: Colors.black,
        ),
        body : 
        Center( 
          child: ListView.builder(
            itemCount: viewModel.stations.length,
            itemBuilder: (context, int index){
              return GestureDetector(
                // Mettre un ID 
                  key: ValueKey<int>(( viewModel.stations.elementAt(index).slugID)),
                  child: Card(
                    child: ListTile(
                      trailing: Text('Comment count : ${viewModel.stations.elementAt(index).commentNumber}'),
                      title: Text("${ viewModel.stations.elementAt(index).slugID} - ${ viewModel.stations.elementAt(index).name}"),
                      subtitle: ( viewModel.stations.elementAt(index).description != null) ? 
                      Text('${ viewModel.stations.elementAt(index).description}'): null
                    ),
                  ),
                onTap: () async {  
                  viewModel.sendToCommentPage(viewModel.stations.elementAt(index).slugName);
                print(viewModel.stations.elementAt(index).slugName);
                setState(() {
                  
                });}
              );
            }))),
      );
  }
}
