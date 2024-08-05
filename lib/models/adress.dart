// To parse this JSON data, do
//
//     final adresses = adressesFromJson(jsonString);

import 'dart:convert';

List<Adresses> adressesFromJson(String str) =>
    List<Adresses>.from(json.decode(str).map((x) => Adresses.fromJson(x)));

String adressesToJson(List<Adresses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Adresses {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  String? adressClass;
  String? type;
  int? placeRank;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  List<String>? boundingbox;

  Adresses({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.adressClass,
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.boundingbox,
  });

  factory Adresses.fromJson(Map<String, dynamic> json) => Adresses(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        adressClass: json["class"],
        type: json["type"],
        placeRank: json["place_rank"],
        importance: json["importance"]?.toDouble(),
        addresstype: json["addresstype"],
        name: json["name"],
        displayName: json["display_name"],
        boundingbox: json["boundingbox"] == null
            ? []
            : List<String>.from(json["boundingbox"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "class": adressClass,
        "type": type,
        "place_rank": placeRank,
        "importance": importance,
        "addresstype": addresstype,
        "name": name,
        "display_name": displayName,
        "boundingbox": boundingbox == null
            ? []
            : List<dynamic>.from(boundingbox!.map((x) => x)),
      };
}
