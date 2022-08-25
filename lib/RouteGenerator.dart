import 'package:flutter/material.dart';
import 'package:swg_gauge_weight/models/Wire.dart';
import 'package:swg_gauge_weight/screens/Dashboard.dart';
import 'package:swg_gauge_weight/screens/FormulaCalculator.dart';
import 'package:swg_gauge_weight/screens/GaugeCalculator.dart';
import 'package:swg_gauge_weight/screens/GaugeResult.dart';
import 'package:swg_gauge_weight/screens/Splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/swgcalculator':
        return MaterialPageRoute(builder: (_) => GaugeCalculator());
      case '/formulacalculator':
        return MaterialPageRoute(builder: (_) => FormulaCalculator());
      case '/swgresult':
        List<Wire> wires = (args as Map)['list'];
        double totalWeight = (args as Map)['weight'];
        return MaterialPageRoute(builder: (_) => GaugeResult(wires, totalWeight));
      default:
        return MaterialPageRoute(builder: (_) => ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Route error'),
      ),
    );
  }
}
