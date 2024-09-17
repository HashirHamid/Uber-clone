import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';

class FavoritePlace {
  final IconData icon;
  final String title;
  final String subtitle;
  final Prediction latlng;

  FavoritePlace(this.icon, this.title, this.subtitle, this.latlng);
}
