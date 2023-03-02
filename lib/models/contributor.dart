import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ContributorResponse contributorResponseFromJson(String str) =>
    ContributorResponse.fromJson(json.decode(str));

String contributorResponseToJson(ContributorResponse data) =>
    json.encode(data.toJson());

class ContributorResponse {
  ContributorResponse({
    this.contributorItem,
  });

  List<ContributorItem> contributorItem;

  factory ContributorResponse.fromJson(Map<String, dynamic> json) =>
      ContributorResponse(
        contributorItem: List<ContributorItem>.from(
            json["ContributorItem"].map((x) => ContributorItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ContributorItem":
            List<dynamic>.from(contributorItem.map((x) => x.toJson())),
      };
  static ContributorResponse contributorResponse = ContributorResponse();
}

class ContributorItem {
  ContributorItem(
      {this.phone,
      this.github,
      this.imageUrl,
      this.linkedin,
      this.name,
      this.email});

  String phone;
  String linkedin;
  String imageUrl;
  String github;
  String name;
  String email;

  factory ContributorItem.fromJson(Map<String, dynamic> json) =>
      ContributorItem(
          phone: json['phone'],
          linkedin: json['linkedin'],
          github: json['github'],
          imageUrl: json['imageUrl'],
          name: json['name'],
          email: json['email']);

  factory ContributorItem.fromFirestore(DocumentSnapshot documentSnapshot) {
    return ContributorItem.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "github": github,
        "imageUrl": imageUrl,
        "linkedin": linkedin,
        "name": name,
        "email": email
      };
}
