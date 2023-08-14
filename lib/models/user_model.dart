import 'dart:convert';

import 'package:car_buying_app/models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? name;
  String? email;
  String? password;
  List<dynamic>? favorite;
  String? imagePath;
  String? imageURL;
  String? uid;
  String? id;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.favorite,
    this.imagePath,
    this.imageURL,
    this.uid,
    this.id
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    imagePath: json["imagePath"],
    imageURL: json["imageURL"],
    uid: json["uid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "imagePath": imagePath,
    "imageURL": imageURL,
    "id": id,
    "uid": uid,
  };

  factory UserModel.fromFirebaseSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
      imagePath: json["imagePath"],
      imageURL: json["imageURL"],
      uid: json["uid"],
      id: json["id"],
    );
  }


}

class Favorite {
  CarModel? cars;

  Favorite({
    this.cars,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    cars: json["cars"],
  );

  Map<String, dynamic> toJson() => {
    "cars": cars,
  };
}
