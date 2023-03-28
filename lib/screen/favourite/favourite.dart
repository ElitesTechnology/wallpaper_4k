import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wish_List extends StatefulWidget{
  // final data;
  // Wish_List(this.data);

  @override
  State<Wish_List> createState() => _Wish_ListState();
}

class _Wish_ListState extends State<Wish_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(""),
            )
        ),
      ),
    );
  }
}