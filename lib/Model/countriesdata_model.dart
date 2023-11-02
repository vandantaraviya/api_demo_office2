

import 'dart:convert';

CountryDataModel countryDataModelFromJson(String str) => CountryDataModel.fromJson(json.decode(str));

String countryDataModelToJson(CountryDataModel data) => json.encode(data.toJson());

class CountryDataModel {
  String status;
  int statusCode;
  String version;
  String access;
  Map<String, Datum> data;

  CountryDataModel({
    required this.status,
    required this.statusCode,
    required this.version,
    required this.access,
    required this.data,
  });

  factory CountryDataModel.fromJson(Map<String, dynamic> json) => CountryDataModel(
    status: json["status"],
    statusCode: json["status-code"],
    version: json["version"],
    access: json["access"],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status-code": statusCode,
    "version": version,
    "access": access,
    "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Datum {
  String country;
  Region region;

  Datum({
    required this.country,
    required this.region,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    country: json["country"] ??"",
    region: regionValues.map[json["region"]]!,
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "region": regionValues.reverse[region],
  };
}

enum Region {
  AFRICA,
  ANTARCTIC,
  ASIA,
  CENTRAL_AMERICA
}

final regionValues = EnumValues({
  "Africa": Region.AFRICA,
  "Antarctic": Region.ANTARCTIC,
  "Asia": Region.ASIA,
  "Central America": Region.CENTRAL_AMERICA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
