import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Hero(
                  child: Image.asset('assets/logo.png'),
                  tag: 'logo',
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 8,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GUAGE CALCULATOR'),
                      const SizedBox(height: 6),
                      Divider(),
                      const SizedBox(height: 6),
                      ListTile(
                        onTap: () => Navigator.pushNamed(context, '/swgcalculator'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Icon(Icons.timeline_sharp, size: 42),
                        title: Text('WIRE GAUGE CALCULATOR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Calculate combination of upto 12 wire gauges', style: TextStyle(fontSize: 10.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 8,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FORMULA CALCULATOR'),
                      const SizedBox(height: 6),
                      Divider(),
                      const SizedBox(height: 6),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/formulacalculator');
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Icon(Icons.timeline_sharp, size: 42),
                        title: Text('FORMULA CALCULATOR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Calculate turns & current', style: TextStyle(fontSize: 10.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//            const SizedBox(height: 16),
//            Card(
//              elevation: 8,
//              margin: const EdgeInsets.all(16),
//              child: Padding(
//                padding: const EdgeInsets.all(12.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text('GUAGE CALCULATOR'),
//                    const SizedBox(height: 6),
//                    Divider(),
//                    const SizedBox(height: 6),
//                    ListTile(
//                      onTap: () {},
//                      trailing: Icon(Icons.arrow_forward_ios),
//                      leading: Icon(Icons.timeline_sharp, size: 42),
//                      title: Text('WIRE GAUGE CALCULATOR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0.sp)),
//                      subtitle: Padding(
//                        padding: const EdgeInsets.symmetric(vertical:8.0),
//                        child: Text('Calculate combination of upto 12 wire gauges', style: TextStyle(fontSize: 10.0.sp)),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}
