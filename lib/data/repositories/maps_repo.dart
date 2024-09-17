import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/data/models/travel_time_model.dart';

class MapsRepository {
  Future<String> getRouteCoordinates(
      Prediction? origin, Prediction? destination) async {
    final url = 'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin?.lat},${origin?.lng}'
        '&destination=${destination?.lat},${destination?.lng}'
        '&key=${dotenv.env["GOOGLE_MAPS_APIKEY"] ?? ""}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'];

      if (routes.isNotEmpty) {
        final polylinePoints = routes[0]['overview_polyline']['points'];
        return polylinePoints;
      }
    } else {
      throw Exception('Failed to load route');
    }

    return "";
  }

  Future<TravelTime> getTravelDetails(
      Prediction? origin, Prediction? destination) async {
    final url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${origin?.lat},${origin?.lng}&destinations=${destination?.lat},${destination?.lng}&key=${dotenv.env["GOOGLE_MAPS_APIKEY"] ?? ""}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        TravelTime data = travelTimeFromMap(response.body);
        return data;
      }
    } catch (e) {
      TravelTime();
    }
    return TravelTime();
  }
}
