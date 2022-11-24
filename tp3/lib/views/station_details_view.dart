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
        Center(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children : <Widget>[ 
            const SizedBox(height: 10,),
            Text("$STATION_NAME ${stationInfo.name}"),
            const SizedBox(height: 10,),
            Text("$SLUG_NAME ${stationInfo.slugName}"),
            const SizedBox(height: 10,),
            Text("$SLUG_ID ${stationInfo.slugID}"),
            const SizedBox(height: 10,),
          (stationInfo.description != null) ? 
             Text("$STATION_DESCRIPTION ${stationInfo.description}") : const Text(NO_STATION_DESCRIPTION),
             const SizedBox(height: 10,),
             (viewModel.commentNumber == -1)?
            Text("$NUMBER_OF_COMMENT ${stationInfo.commentNumber}") :Text("$NUMBER_OF_COMMENT ${viewModel.commentNumber}") ,
            const SizedBox(height: 10,),
            const Text(STATION_LAST_MEASURE),
            SizedBox( width: 75.0,
            height: 42.0,
            child: DecoratedBox(
              decoration:  BoxDecoration(
                color: viewModel.getStationColor(viewModel.pm25Average),
              ),
              child: Center(
                child: Text('${viewModel.pm25Average} μg/m3'),
              ),))
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
