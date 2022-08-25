import 'package:swg_gauge_weight/models/Wire.dart';

class Statics {
  static List<Wire> SWGWiresList() {
    List<Wire> wires = List();
    wires.add(Wire(16, 64, 0.3, 67, (64 * 64).toDouble()));
    wires.add(Wire(17, 56, 0.3, 59, (56 * 56).toDouble()));
    wires.add(Wire(18, 48, 0.3, 51, (48 * 48).toDouble()));
    wires.add(Wire(19, 40, 0.3, 43, (40 * 40).toDouble()));
    wires.add(Wire(20, 36, 2.5, 38.5, (36 * 36).toDouble()));
    wires.add(Wire(21, 32, 2.5, 34.5, (32 * 32).toDouble()));
    wires.add(Wire(22, 28, 2.5, 30, (28 * 28).toDouble()));
    wires.add(Wire(23, 24, 2.5, 26, (24 * 24).toDouble()));
    wires.add(Wire(24, 22, 2.0, 24, (22 * 22).toDouble()));
    wires.add(Wire(25, 20, 1.9, 22, (20 * 20).toDouble()));
    wires.add(Wire(26, 18, 1.9, 19.9, (18 * 18).toDouble()));
    wires.add(Wire(27, 16.4, 1.9, 18, (16.4 * 16.4).toDouble()));
    wires.add(Wire(28, 14.8, 1.6, 16.5, (14.8 * 14.8).toDouble()));
    wires.add(Wire(29, 13.6, 1.6, 15.1, (13.6 * 13.6).toDouble()));
    wires.add(Wire(30, 12.4, 1.5, 13.9, (12.4 * 12.4).toDouble()));
    return wires;
  }
}
