import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Stations.dart';

class AllStationPage extends StatefulWidget {
  const AllStationPage({super.key, required this.title});

  final String title;

  @override
  State<AllStationPage> createState() => _AllStationPageState();
}

class _AllStationPageState extends State<AllStationPage> {

  List<ActiveStation> activeStationList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    loadStations();
    Timer(Duration(seconds: 1), () => setState(() {
      
    }));
  }  

  void loadStations() async {
    activeStationList = await fetchActiveStation(http.Client());
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: const Text("Stations"),
          backgroundColor: Colors.black,
          
        ),
        body : 
        Center( 
          child: Scrollbar(
          child: ListView.builder(
            itemCount: activeStationList.length,
            itemBuilder: (context, int index){
              return GestureDetector(
                // Mettre un ID 
                  key: ValueKey<int>((activeStationList.elementAt(index).slugID)),
                  child: Card(
                    child: ListTile(
                      title: Text("${activeStationList.elementAt(index).slugID} - ${activeStationList.elementAt(index).name}"),
                      subtitle: (activeStationList.elementAt(index).description != null) ? 
                      Text('${activeStationList.elementAt(index).description}'): null
                    ),
                  ),
                onTap: () async {  /* Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) =>  DetailsPage( taskList: taskList,task: taskList.taskList[index],))
                );
                _onChangedFilter(_selectedFilter); */
                print("Bon matin");
                setState(() {
                  
                });}
              );
            }))),
      );
  }
}