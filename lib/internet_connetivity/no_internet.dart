import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class No_INternet extends StatelessWidget {
  const No_INternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xF7060709),
          title: Text('4K Wallpaper'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  "No Internet Connection...",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Center(
                child: Text(
                  "Please Check Your Connection",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text("Exit"),
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ));
  }
}
