import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uber_clone/data/models/favorite_place_model.dart';
import 'package:uber_clone/data/models/ride_model.dart';

final dummyPlaces = [
  FavoritePlace(Icons.home, "Home", "House 64-A, Street 10, XYZ Town",
      Prediction(lat: "33.55755004270239", lng: "73.16298096081854")),
  FavoritePlace(Icons.work, "Work", "DaftarKhwan Vantage, Phase 7, Bahria Town",
      Prediction(lat: "33.52108419152828", lng: "73.10539713618864")),
];

final rideTypes = [
  RideModel(
    id: "Uber-X-123",
    title: "Uber X",
    multiplier: 1,
    image: "https://links.papareact.com/3pn",
  ),
  RideModel(
    id: "Uber-XL-123",
    title: "Uber XL",
    multiplier: 1.2,
    image: "https://links.papareact.com/5w8",
  ),
  RideModel(
    id: "Uber-LUX-123",
    title: "Uber LUX",
    multiplier: 1.5,
    image: "https://links.papareact.com/7pf",
  ),
];
