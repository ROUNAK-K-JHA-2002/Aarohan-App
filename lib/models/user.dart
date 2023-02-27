// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.name,
    this.email,
    this.photoURL,
    this.id,
    this.calendar
  });

  String name;
  String email;
  String photoURL;
  String id;
  List calendar;

  factory Users.fromJson(Map<dynamic, dynamic> json) => Users(
    name: json["name"],
    email: json["email"],
    photoURL: json["photoURL"],
    id: json["id"],
    calendar: json["calendar"]
  );

  factory Users.fromFirestore(DocumentSnapshot documentSnapshot) {
    return Users.fromJson(documentSnapshot.data());
  }

  Map<dynamic, dynamic> toJson() => {
    "name": name,
    "email": email,
    "photoURL": photoURL,
    "id": id,
    "calendar" :calendar
  };
  static Users us = Users();

}

