import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_4k/screen/home_screen/home_screen.dart';

class Splash_Screen extends StatefulWidget{
  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home_Page())));
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "asset/images/screen.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit:BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Welcom to',style: GoogleFonts.roboto(color: Color(
                    0xbefdfdfd),fontWeight:FontWeight.bold),textScaleFactor: 1),
                Center(
                    child: Text('4K Wallpaper',style: GoogleFonts.roboto(color: Color(
                        0xdafdfdfd),fontWeight:FontWeight.bold),textScaleFactor: 2.1)),
                SizedBox(
                  height: _height*0.4,
                ),
                Text('Find Wallpapers Of your choice',style: GoogleFonts.roboto(color: Color(
                    0xbefdfdfd),fontWeight:FontWeight.bold),textScaleFactor: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}