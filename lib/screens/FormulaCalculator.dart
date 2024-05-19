import 'dart:math';
import 'package:flutter/material.dart';

class FormulaCalculator extends StatefulWidget {
  @override
  _FormulaCalculatorState createState() => _FormulaCalculatorState();
}

class _FormulaCalculatorState extends State<FormulaCalculator> {
  ValueNotifier<int> pollsListenable = ValueNotifier(null);
  ValueNotifier<double> formulaAnswer = ValueNotifier(null);
  TextEditingController controllerDia = TextEditingController();
  TextEditingController controllerLength = TextEditingController();
  TextEditingController controllerVolts = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('FORMULA CALCULATOR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CORE DIAMETER'),
                          const SizedBox(height: 4),
                          Divider(),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.blur_circular, size: 20.0),
                            title: TextField(
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              controller: controllerDia,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(),
                                hintText: 'Diameter',
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text('Enter diameter of core in inches', style: TextStyle(fontSize: 10.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('POLL'),
                          const SizedBox(height: 4),
                          Divider(),
                          ValueListenableBuilder<int>(
                            builder: (_, int value, __) {
                              return ListTile(
                                dense: true,
                                leading: Icon(Icons.poll_outlined, size: 20.0),
                                title: DropdownButton<int>(
                                  value: value,
                                  onChanged: (int select) {
                                    pollsListenable.value = select;
                                  },
                                  hint: Text('Select Option'),
                                  isExpanded: true,
                                  items: List<int>.generate(5, (i) => (i + 1) * 2)
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Text('$e'),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text('Select number of polls', style: TextStyle(fontSize: 10.0)),
                                ),
                              );
                            },
                            valueListenable: pollsListenable,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CORE LENGTH'),
                          const SizedBox(height: 4),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.height, size: 20.0),
                            dense: true,
                            title: TextField(
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              controller: controllerLength,
                              decoration: InputDecoration(focusedBorder: UnderlineInputBorder(), hintText: 'Length'),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text('Enter length of core in inches', style: TextStyle(fontSize: 10.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('VOLTS'),
                          const SizedBox(height: 4),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.timeline, size: 20.0),
                            title: TextField(
                              controller: controllerVolts,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(focusedBorder: UnderlineInputBorder(), hintText: 'Volts'),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text('Enter suitable volts', style: TextStyle(fontSize: 10.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(6.0),
            child: ValueListenableBuilder<double>(
              builder: (_, double answer, __) {
                if (answer == null) {
                  return SizedBox();
                }
                return Text(
                  '${answer.round()}\nTurns Per Set',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                );
              },
              valueListenable: formulaAnswer,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                if (controllerDia.text.isNotEmpty && controllerLength.text.isNotEmpty && controllerVolts.text.isNotEmpty && pollsListenable.value != null) {
                  calculateTurns();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Some fields are missings'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              // color: Colors.orange.shade800,
              // elevation: 6,
              // child: Text('CALCULATE'),
              // textColor: Colors.white,
              // padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  void calculateTurns() {
    double diameter = double.parse(controllerDia.text);
    int polls = pollsListenable.value;
    double length = double.parse(controllerLength.text);
    int volts = int.parse(controllerVolts.text);

    double diaInSooter = (diameter); // / 0.8;
    double lengthInSooter = (length); // / 0.8;

    formulaAnswer.value = (15.6 / (length * diameter * pi)) * volts;

//    double someAnswer = (((diaInSooter * pi) / polls) * lengthInSooter);
//    double turnsPerSet = ((8 / someAnswer) * volts) / (polls / 2);
//    turnsPerSet = turnsPerSet/0.8;
//    formulaAnswer.value = turnsPerSet;
  }
}

// ans = ((dia * pie) / pole) * length
// ((8 / ans) * volts) / halfOfPole
