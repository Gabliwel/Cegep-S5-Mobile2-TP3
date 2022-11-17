import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ActiveStation>> fetchActiveStation(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://test.revolvair.org/api/revolvair/stations/'));
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    /* print(ActiveStation.getAllActiveStation(ActiveStation.getAllStation(jsonDecode(response.body)))); */
    return ActiveStation.getAllActiveStation(ActiveStation.getAllStation(jsonDecode(response.body)));
  } else {
    throw Exception('Failed to load actives station');
  } 
}


class ActiveStation{
  final int slugID;
  final String name;
  final String? description;
  final int? ownerId; 
  

  const ActiveStation({
    required this.slugID,
    required this.name,
    required this.description,
    required this.ownerId,
  });

  static List<dynamic> getAllStation(Map<String, dynamic> json){
    return json.values.first;
  }

  static List<ActiveStation> getAllActiveStation(List<dynamic> allStation){
    List<ActiveStation> activeStationList = List.empty(growable: true);
    
    for (var i = 0 ; i < allStation.length;  i++)
    {
      if(allStation[i]["activate"] == 1 ){
        activeStationList.add(ActiveStation(
          slugID : allStation[i]["id"],
          name :allStation[i]["name"],
          description : allStation[i]["description"],
          ownerId : allStation[i]["user_id"]
          ));
      }
    }
    return activeStationList;
  }

  @override
  String toString() => '''
    SlugId : $slugID
    Name: $name
    Desc: $description
    Owner ID: $ownerId
    ''';
}