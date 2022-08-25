import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swg_gauge_weight/Statics.dart';
import 'package:swg_gauge_weight/models/Wire.dart';
import 'package:swg_gauge_weight/providers/GaugeCalculationProvider.dart';

class GaugeCalculator extends StatefulWidget {
  @override
  _GaugeCalculatorState createState() => _GaugeCalculatorState();
}

class _GaugeCalculatorState extends State<GaugeCalculator> {
  TextEditingController weightController = TextEditingController();
  ValueNotifier<int> totalViews = ValueNotifier<int>(2);

  List<Wire> selectedWiresWithQuantity = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('GAUGE CALCULATOR'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              totalViews.value = totalViews.value + 1;
            },
          ),
          ValueListenableBuilder(
            valueListenable: totalViews,
            builder: (_, int value, __) {
              return IconButton(
                icon: Icon(Icons.remove_circle_outline_sharp),
                onPressed: value > 2
                    ? () {
                        if (selectedWiresWithQuantity.length > 2) {
                          selectedWiresWithQuantity.removeLast();
                        }
                        totalViews.value = totalViews.value - 1;
                      }
                    : null,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.0.sp),
                  Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TOTAL WEIGHT'),
                          const SizedBox(height: 6),
                          Divider(),
                          const SizedBox(height: 6),
                          ListTile(
                            leading: Icon(FontAwesomeIcons.weightHanging, size: 42),
                            title: TextField(
                              controller: weightController,
                              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                              decoration: InputDecoration(
                                suffixText: 'Grams',
                                focusedBorder: UnderlineInputBorder(),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('Enter total weight in grams', style: TextStyle(fontSize: 10.0.sp)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0.sp),
                  ValueListenableBuilder<int>(
                    valueListenable: totalViews,
                    builder: (_, int views, __) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: views,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Card(
                              elevation: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<int>(
                                        isExpanded: true,
                                        value: selectedWiresWithQuantity.length > index ? selectedWiresWithQuantity[index].swg : null,
                                        onChanged: (int swg) {
                                          Wire wire = Statics.SWGWiresList().singleWhere((element) => element.swg == swg);
                                          setState(() {
                                            this.selectedWiresWithQuantity.insert(index, wire);
                                          });
                                        },
                                        hint: Text('Select gauge'),
                                        style: TextStyle(color: Colors.black87),
                                        focusColor: Colors.black87,
                                        items: Statics.SWGWiresList()
                                            .map(
                                              (e) => DropdownMenuItem(
                                                child: Text(
                                                  '${e.swg}',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                value: e.swg,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(child: Text('X', textAlign: TextAlign.center)),
                                    Expanded(
                                      child: DropdownButton<int>(
                                        value: selectedWiresWithQuantity.length > index ? selectedWiresWithQuantity[index].numbers : null,
                                        onChanged: (int quantity) {
                                          if (selectedWiresWithQuantity.length > index) {
                                            Wire wire = selectedWiresWithQuantity[index];
                                            wire.numbers = quantity;
                                            setState(() {
                                              selectedWiresWithQuantity.removeAt(index);
                                              selectedWiresWithQuantity.insert(index, wire);
                                            });
                                          }
                                        },
                                        isExpanded: true,
                                        hint: Text('Total Wire'),
                                        style: TextStyle(color: Colors.black87),
                                        focusColor: Colors.black87,
                                        items: List<int>.generate(10, (i) => i + 1)
                                            .toList()
                                            .map(
                                              (e) => DropdownMenuItem(
                                                child: Text(
                                                  '$e',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                value: e,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(12.0.sp),
            child: RaisedButton(
              onPressed: () {
                bool validation = false;
                selectedWiresWithQuantity.forEach((element) {
                  validation = element.numbers != null;
                });
                if (validation && weightController.text.isNotEmpty) {
                  Navigator.pushReplacementNamed(context, '/swgresult',
                      arguments: {'list': selectedWiresWithQuantity, 'weight': double.parse(weightController.text)});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some fields are missings'), backgroundColor: Colors.redAccent));
                }
              },
              color: Colors.orange.shade800,
              elevation: 6,
              child: Text('CALCULATE'),
              textColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }
}
