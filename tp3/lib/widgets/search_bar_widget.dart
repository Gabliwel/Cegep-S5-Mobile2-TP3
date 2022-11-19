import 'package:flutter/material.dart';
import 'package:tp3/viewmodels/station_viewmodel.dart';

import '../models/station.dart';

//https://www.geeksforgeeks.org/flutter-search-bar/
class SearchBar extends SearchDelegate{
  List<Station> searchList;
  StationsViewModel stationViewModel;
  SearchBar({required this.searchList, required this.stationViewModel});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Station> matchQuery = [];
    for (var station in searchList) {
      if (station.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(station);
      }
    }
    return ResearchBuildTileList(matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Station> matchQuery = [];
    for (var station in searchList) {
      if (station.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(station);
      }
    }
    return ResearchBuildTileList(matchQuery);
  }

  ListView ResearchBuildTileList(matchQuery){
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
           return GestureDetector(
                  key: ValueKey<int>(( result.slugID)),
                  child: Card(
                    child: ListTile(
                      trailing: Text('Comment count : ${result.commentNumber}'),
                      title: Text("${ result.slugID} - ${ result.name}"),
                      subtitle: ( result.description != null) ? 
                      Text('${ result.description}'): null
                    ),
                  ),
                onTap: () async {  
                  stationViewModel.sendToCommentPage(result.slugName);
                }
              );
      },
    );
  }
}