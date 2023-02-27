// To parse this JSON data, do
//
//     final scheduleResponse = scheduleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ScheduleResponse scheduleResponseFromJson(String str) =>
    ScheduleResponse.fromJson(json.decode(str));

String scheduleResponseToJson(ScheduleResponse data) => json.encode(data.toJson());

class ScheduleResponse {
  ScheduleResponse({
    this.dayItem,
  });

  List<DayItem> dayItem;

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) => ScheduleResponse(
    dayItem: List<DayItem>.from(
        json["DayItem"].map((x) => DayItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DayItem": List<dynamic>.from(dayItem.map((x) => x.toJson())),
  };
  static ScheduleResponse scheduleResponse = ScheduleResponse();
}

class DayItem {
  DayItem({
    this.events
  });

  List events;

  factory DayItem.fromJson(Map<String, dynamic> json) => DayItem(
    events: json['events']
  );

  factory DayItem.fromFirestore(DocumentSnapshot documentSnapshot) {
    return DayItem.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
    "events":events
  };
}