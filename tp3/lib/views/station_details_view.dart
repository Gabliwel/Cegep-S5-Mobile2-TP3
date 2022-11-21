import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tp3/models/station.dart';
import 'package:tp3/viewmodels/station_details_viewmodel.dart';
import 'package:tp3/utils/constants.dart';

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
       
        body : viewModel.isBusy
        ? const Center(child: CircularProgressIndicator()) :
        Container(
          alignment: Alignment.center,
          child:
        Column(
          children : <Widget>[ 
            Text("$STATION_NAME ${stationInfo.name}"),
            Text("$SLUG_NAME ${stationInfo.slugName}"),
            Text("$SLUG_ID ${stationInfo.slugID}"),
          (stationInfo.description != null) ? 
             Text("$STATION_DESCRIPTION ${stationInfo.description}") : const Text(NO_STATION_DESCRIPTION),
            Text("$NUMBER_OF_COMMENT ${stationInfo.commentNumber}"),
            Text("$STATION_LAST_MEASURE ${viewModel.pm25Average}"),
              ],
            )
          ),
          floatingActionButton: 
            FloatingActionButton(
        child: const Icon(Icons.comment),
          onPressed: () async {
            viewModel.sendToCommentPage(stationInfo.slugName);
  }),)
      );
  }
}
