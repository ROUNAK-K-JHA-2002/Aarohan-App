// To parse this JSON data, do
//
//     final eventResponse = eventResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

EventResponse eventResponseFromJson(String str) =>
    EventResponse.fromJson(json.decode(str));

String eventResponseToJson(EventResponse data) => json.encode(data.toJson());

class EventResponse {
  EventResponse({
    this.eventItem,
  });

  List<EventItem> eventItem;

  factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
    eventItem: List<EventItem>.from(
        json["EventItem"].map((x) => EventItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "EventItem": List<dynamic>.from(eventItem.map((x) => x.toJson())),
  };
  static EventResponse eventResponse = EventResponse();
}

class EventItem {
  EventItem({
    this.title,
    this.body,
    this.imageUrl,
    this.date,
    this.category,
    this.tag,
    this.link,
    this.location,
    this.contact,
    this.time
  });

  String title;
  String body;
  String imageUrl;
  String date;
  String category;
  List tag;
  String link;
  String location;
  String contact;
  String time;

  factory EventItem.fromJson(Map<String, dynamic> json) => EventItem(
    title: json["title"],
    body: json["body"],
    imageUrl: json["imageUrl"],
    date: json["date"],
    category: json["category"],
    tag: json["tag"],
    link: json["link"],
    location: json["location"],
    contact: json["contact"],
    time: json['time']
  );

  factory EventItem.fromFirestore(DocumentSnapshot documentSnapshot) {
    return EventItem.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "imageUrl": imageUrl,
    "date": date,
    "category": category,
    "tag": tag,
    "link": link,
    "location": location,
    "contact": contact,
    "time":time
  };
}