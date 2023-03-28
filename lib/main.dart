import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_4k/internet_connetivity/connetivity_provider.dart';
import 'package:wallpaper_4k/modal/adprovider.dart';
import 'package:wallpaper_4k/screen/splash_screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await MobileAds.instance.initialize();
  runApp(MaterialApp(
    // debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  ThemeData _lightTheme =
  ThemeData(brightness: Brightness.light, primaryColor: Colors.grey);
  ThemeData _dartTheme =
  ThemeData(brightness: Brightness.dark, primaryColor: Colors.green);
  bool _light = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: Splash_Screen(),
        ),
        ChangeNotifierProvider(create: (context) => AdProvider())
      ],
      child: MaterialApp(
        theme: _light ? _dartTheme : _lightTheme,
        debugShowCheckedModeBanner: false,
        home: Splash_Screen(),
      ),
    );
  }
}