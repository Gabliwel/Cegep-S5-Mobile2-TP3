import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tp3/viewmodels/station_details_viewmodel.dart';
import 'package:tp3/views/station_details_view.dart';

void main() {
   StationDetailsViewModel viewModel =StationDetailsViewModel();
  group("StationsViewModel - getStationColor ", () {
    test(
        "Retourne la la couleur verte si la condition est remplie",
        () {
         
          expect(viewModel.getStationColor(2), const Color.fromARGB(255, 50, 195, 65));
        }); 
});
}