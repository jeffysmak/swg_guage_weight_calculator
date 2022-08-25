import 'package:flutter/material.dart';
import 'package:swg_gauge_weight/models/Wire.dart';

class GaugeCalculationProvider extends ChangeNotifier {
  List<Wire> gaugeWiresSelected;
  int totalWeightInKilograms;

  GaugeCalculationProvider() {
    this.gaugeWiresSelected = List();
  }

  void updateWeight(int weight) {
    this.totalWeightInKilograms = weight;
    notifyListeners();
  }

  void addSelectionWire(List<Wire> wire) {
    this.gaugeWiresSelected = wire;
    notifyListeners();
  }

  double calculateSingleWeight(Wire wire) {
    double a = 0;
    gaugeWiresSelected.forEach((element) {
      a = a + (element.copperSquare * element.numbers);
    });
    return wire.copperSquare/a;
  }
}
