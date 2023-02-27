
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SponsorResponse sponsorResponseFromJson(String str) =>
    SponsorResponse.fromJson(json.decode(str));

String sponsorResponseToJson(SponsorResponse data) =>
    json.encode(data.toJson());

class SponsorResponse {
  SponsorResponse({
    this.sponsorItem,
  });

  List<SponsorItem> sponsorItem;

  factory SponsorResponse.fromJson(Map<String, dynamic> json) =>
      SponsorResponse(
        sponsorItem: List<SponsorItem>.from(
            json["SponsorItem"].map((x) => SponsorItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "SponsorItem": List<dynamic>.from(sponsorItem.map((x) => x.toJson())),
  };
  static SponsorResponse sponsorResponse = SponsorResponse();
}

class SponsorItem {
  SponsorItem({
    this.category,
    this.description,
    this.imageUrl,
    this.priority
  });

  String category;
  String priority;
  String imageUrl;
  String description;

  factory SponsorItem.fromJson(Map<String, dynamic> json) =>
      SponsorItem(category: json['category'],
        priority: json['priority'],
        description: json['description'],
        imageUrl: json['imageUrl'],

      );

  factory SponsorItem.fromFirestore(DocumentSnapshot documentSnapshot) {
    return SponsorItem.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {"category" : category,
    "description" : description,
    "imageUrl" : imageUrl,
    "priority" : priority
  };
}