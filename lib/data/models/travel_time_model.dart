import 'dart:convert';

TravelTime travelTimeFromMap(String str) =>
    TravelTime.fromMap(json.decode(str));

String travelTimeToMap(TravelTime data) => json.encode(data.toMap());

class TravelTime {
  final List<String>? destinationAddresses;
  final List<String>? originAddresses;
  final List<Row>? rows;
  final String? status;

  TravelTime({
    this.destinationAddresses,
    this.originAddresses,
    this.rows,
    this.status,
  });

  factory TravelTime.fromMap(Map<String, dynamic> json) => TravelTime(
        destinationAddresses: json["destination_addresses"] == null
            ? []
            : List<String>.from(json["destination_addresses"]!.map((x) => x)),
        originAddresses: json["origin_addresses"] == null
            ? []
            : List<String>.from(json["origin_addresses"]!.map((x) => x)),
        rows: json["rows"] == null
            ? []
            : List<Row>.from(json["rows"]!.map((x) => Row.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "destination_addresses": destinationAddresses == null
            ? []
            : List<dynamic>.from(destinationAddresses!.map((x) => x)),
        "origin_addresses": originAddresses == null
            ? []
            : List<dynamic>.from(originAddresses!.map((x) => x)),
        "rows":
            rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toMap())),
        "status": status,
      };
}

class Row {
  final List<Element>? elements;

  Row({
    this.elements,
  });

  factory Row.fromMap(Map<String, dynamic> json) => Row(
        elements: json["elements"] == null
            ? []
            : List<Element>.from(
                json["elements"]!.map((x) => Element.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "elements": elements == null
            ? []
            : List<dynamic>.from(elements!.map((x) => x.toMap())),
      };
}

class Element {
  final Distance? distance;
  final Distance? duration;
  final String? status;

  Element({
    this.distance,
    this.duration,
    this.status,
  });

  factory Element.fromMap(Map<String, dynamic> json) => Element(
        distance: json["distance"] == null
            ? null
            : Distance.fromMap(json["distance"]),
        duration: json["duration"] == null
            ? null
            : Distance.fromMap(json["duration"]),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "distance": distance?.toMap(),
        "duration": duration?.toMap(),
        "status": status,
      };
}

class Distance {
  final String? text;
  final int? value;

  Distance({
    this.text,
    this.value,
  });

  factory Distance.fromMap(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "value": value,
      };
}
