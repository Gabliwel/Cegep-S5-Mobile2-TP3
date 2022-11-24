class Station{
  final int slugID;
  final String name;
  final String? description;
  final int? ownerId;
  final String slugName; 
  final int commentNumber;
  

  const Station({
    required this.slugID,
    required this.name,
    required this.description,
    required this.ownerId,
    required this.slugName,
    required this.commentNumber,
  });

  static List<dynamic> getAllStation(Map<String, dynamic> json){
    return json.values.first;
  }

  static List<Station> getAllActiveStation(List<dynamic> allStation){
    List<Station> activeStationList = List.empty(growable: true);
    
    for (var i = 0 ; i < allStation.length;  i++)
    {
      if(allStation[i]["activate"] == 1 ){
        activeStationList.add(Station(
          slugID : allStation[i]["id"],
          name :allStation[i]["name"],
          description : allStation[i]["description"],
          ownerId : allStation[i]["user_id"],
          slugName: allStation[i]["slug"],
          commentNumber: allStation[i]["comment_count"],
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
    Slug Name: $slugName
    ''';
}
