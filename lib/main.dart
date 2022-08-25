import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer_util.dart';
import 'package:swg_gauge_weight/ABC.dart';
import 'package:swg_gauge_weight/RouteGenerator.dart';
import 'package:swg_gauge_weight/providers/GaugeCalculationProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0x0ff26242e),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GaugeCalculationProvider>(
          create: (BuildContext ctx) => GaugeCalculationProvider(),
        ),
      ],
      child: LayoutBuilder(
        builder: (ctx, cons) {
          return OrientationBuilder(
            builder: (ctx, orientation) {
              SizerUtil().init(cons, orientation);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "PMES",
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: '/',
                navigatorObservers: [routeObserver],
                theme: ThemeData(
                  primaryColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      iconTheme: IconThemeData(color: Colors.black87),
                      titleTextStyle: Theme.of(context).textTheme.button.copyWith(fontWeight: FontWeight.bold)),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
                  brightness: Brightness.light,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
