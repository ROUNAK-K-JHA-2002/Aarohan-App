import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PrelimResponse prelimResponseFromJson(String str) =>
    PrelimResponse.fromJson(json.decode(str));

String prelimResponseToJson(PrelimResponse data) =>
    json.encode(data.toJson());

class PrelimResponse {
  PrelimResponse({
    this.prelimItem,
  });

  List<PrelimItem> prelimItem;

  factory PrelimResponse.fromJson(Map<String, dynamic> json) =>
      PrelimResponse(
        prelimItem: List<PrelimItem>.from(
            json["PrelimItem"].map((x) => PrelimItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "PrelimItem": List<dynamic>.from(prelimItem.map((x) => x.toJson())),
  };
  static PrelimResponse prelimResponse = PrelimResponse();
}

class PrelimItem {
  PrelimItem({this.url,this.title});

  String url;   String title;

  factory PrelimItem.fromJson(Map<String, dynamic> json) => PrelimItem(
      url: json['url'],

    title: json['title']
  );

  factory PrelimItem.fromFirestore(DocumentSnapshot documentSnapshot) {
    return PrelimItem.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() =>
      {'url':url,'title':title};
}