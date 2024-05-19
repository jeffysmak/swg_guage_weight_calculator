import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:swg_gauge_weight/models/Wire.dart';

class GaugeResult extends StatefulWidget {
  List<Wire> wiresWithQuantity;
  double totalWeight;

  GaugeResult(this.wiresWithQuantity, this.totalWeight);

  @override
  _GaugeResultState createState() => _GaugeResultState();
}

class _GaugeResultState extends State<GaugeResult> {
  ValueNotifier<double> calculatedResult = ValueNotifier<double>(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculatedResult.value =
        widget.wiresWithQuantity.fold(0, (previousValue, element) => (previousValue + (element.numbers * calculateSingleWeight(element).round())).roundToDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              StringBuffer toShare = StringBuffer();
              widget.wiresWithQuantity.forEach((element) {
                toShare.writeln('# ${element.swg}  Single : ${calculateSingleWeight(element)} Grams');
                toShare.writeln(
                    '${element.swg} x ${element.numbers}  ${calculateSingleWeight(element)} x ${element.numbers} = ${element.numbers * calculateSingleWeight(element).toInt().round()} Grams');
                if (widget.wiresWithQuantity.last != element) {
                  toShare.writeln('\n\n\n');
                } else {
                  toShare.writeln('\nOwned By : PIR MUKHTAR ELECTRIC STORE SARGODHA');
                }
              });
              Share.share(toShare.toString());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.wiresWithQuantity.map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Text('${e.swg}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                        title: Text('Single - ${calculateSingleWeight(e)} Grams', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            '${e.swg} x ${e.numbers}      ${calculateSingleWeight(e)} x ${e.numbers}   =   ${e.numbers * calculateSingleWeight(e).toInt().round()} Grams'),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(24.0),
            child: ValueListenableBuilder<double>(
              valueListenable: calculatedResult,
              builder: (_, value, __) {
                return Text(
                  '${value / 1000} KG\nTOTAL EXPECTED RESULT',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int calculateSingleWeight(Wire wire) {
    double a = 0;
    widget.wiresWithQuantity.forEach((element) {
      a = a + (element.copperSquare * element.numbers);
    });
    return (((wire.copperSquare / a) * widget.totalWeight) / 5).round() * 5;
  }
}
