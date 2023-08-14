// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
  String? id;
  String? name;
  String? seat;
  String? speed;
  String? imageUrl;

  CarModel({
    this.id,
    this.name,
    this.seat,
    this.speed,
    this.imageUrl,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    id: json["id"],
    name: json["name"],
    seat: json["seat"],
    speed: json["speed"],
    imageUrl: json["imageURL"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seat": seat,
    "speed": speed,
    "imageURL": imageUrl,
  };

  factory CarModel.fromFirebaseSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) {
    return CarModel(
      id: json["id"],
      name: json["name"],
      seat: json["seat"],
      speed: json["speed"],
      imageUrl: json["imageURL"],
    );
  }

}
