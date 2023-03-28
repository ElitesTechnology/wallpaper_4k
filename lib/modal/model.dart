// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.wallpaper,
  });

  List<Wallpaper> wallpaper;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    wallpaper: List<Wallpaper>.from(json["Wallpaper"].map((x) => Wallpaper.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Wallpaper": List<dynamic>.from(wallpaper.map((x) => x.toJson())),
  };
}

class Wallpaper {
  Wallpaper({
    required this.id,
    required this.image,
    required this.title,
    required this.subcat,
  });

  int id;
  String image;
  String title;
  List<Subcat> subcat;

  factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    subcat: List<Subcat>.from(json["Subcat"].map((x) => Subcat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "Subcat": List<dynamic>.from(subcat.map((x) => x.toJson())),
  };
}

class Subcat {
  Subcat({
    required this.id1,
    required this.image1,
  });

  int id1;
  String image1;

  factory Subcat.fromJson(Map<String, dynamic> json) => Subcat(
    id1: json["id1"],
    image1: json["image1"],
  );

  Map<String, dynamic> toJson() => {
    "id1": id1,
    "image1": image1,
  };
}
