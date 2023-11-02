import 'dart:convert';

List<Datamodel> datamodelFromJson(String str) => List<Datamodel>.from(json.decode(str).map((x) => Datamodel.fromJson(x)));

String datamodelToJson(List<Datamodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Datamodel {
  String? stateProvince;
  String country;
  List<String> domains;
  List<String> webPages;
  String alphaTwoCode;
  String name;

  Datamodel({
    required this.stateProvince,
    required this.country,
    required this.domains,
    required this.webPages,
    required this.alphaTwoCode,
    required this.name,
  });

  factory Datamodel.fromJson(Map<String, dynamic> json) => Datamodel(
    stateProvince: json["state-province"] ??"",
    country: json["country"]??"",
    domains: List<String>.from(json["domains"].map((x) => x)),
    webPages: List<String>.from(json["web_pages"].map((x) => x)),
    alphaTwoCode: json["alpha_two_code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "state-province": stateProvince,
    "country":   countryValues.reverse[country],
    "domains": List<dynamic>.from(domains.map((x) => x)),
    "web_pages": List<dynamic>.from(webPages.map((x) => x)),
    "alpha_two_code": alphaTwoCodeValues.reverse[alphaTwoCode],
    "name": name,
  };
}

enum AlphaTwoCode {
  IN
}

final alphaTwoCodeValues = EnumValues({
  "IN": AlphaTwoCode.IN
});

enum Country {
  INDIA
}

final countryValues = EnumValues({
  "India": Country.INDIA
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
