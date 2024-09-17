import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uber_clone/data/models/travel_time_model.dart';
import 'package:uber_clone/data/repositories/maps_repo.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsStates> {
  Prediction? origin;
  Prediction? destination;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  final MapsRepository _mapsRepository = MapsRepository();
  TravelTime? travelTime;

  GoogleMapController? mapsController;

  MapsBloc() : super(const MapsStates()) {
    on<InitialMapEvent>(intialEvent);
    on<DestinationEvent>(enableButton);
    on<NoDestinationEvent>(disableButton);
    on<AddOriginMarkerEvent>(originMarker);
    on<AddDestinationMarkerEvent>(destinationMarker);
  }

  enableButton(DestinationEvent event, Emitter<MapsStates> emit) {
    emit(
      state.copyWith(
        destinationEntered: true,
      ),
    );
  }

  intialEvent(InitialMapEvent event, Emitter<MapsStates> emit) {
    emit(
      state.copyWith(
        destinationEntered: true,
      ),
    );
  }

  disableButton(NoDestinationEvent event, Emitter<MapsStates> emit) {
    List<Marker> list = markers.toList();
    list.removeAt(1);
    markers = list.toSet();
    polylines.clear();
    _zoomToFitMarkersAndPolyline();
    emit(
      state.copyWith(
        destinationEntered: false,
        markers: markers,
        polylines: polylines,
      ),
    );
  }

  originMarker(AddOriginMarkerEvent event, Emitter<MapsStates> emit) {
    final position = LatLng(latitude(origin), longitude(origin));
    final marker = Marker(
        markerId: MarkerId(origin.toString()),
        position: position,
        infoWindow: const InfoWindow(title: "Origin"));
    markers.clear();
    markers.add(marker);

    emit(
      MapsStates(
        markers: markers,
      ),
    );
    mapsController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(latitude(origin), longitude(origin))));
  }

  destinationMarker(
      AddDestinationMarkerEvent event, Emitter<MapsStates> emit) async {
    final marker = Marker(
        markerId: MarkerId(destination?.lat.toString() ?? "1"),
        position: LatLng(latitude(destination), longitude(destination)),
        infoWindow: const InfoWindow(title: "Destination"));

    if (markers.length == 2) {
      List<Marker> myMarkers = markers.toList();
      myMarkers[1] = marker;
      markers = myMarkers.toSet();
    } else {
      markers.add(marker);
    }

    final polyline = await generatePolyline();
    polylines.add(polyline);

    emit(
      state.copyWith(
        destinationEntered: true,
        markers: markers,
        polylines: polylines,
      ),
    );
  }

  Future<Polyline> generatePolyline() async {
    final pointsString =
        await _mapsRepository.getRouteCoordinates(origin, destination);
    travelTime = await _mapsRepository.getTravelDetails(origin, destination);

    final List<LatLng> points = _decodePolyline(pointsString);

    final polyline = Polyline(
        polylineId: const PolylineId("Line"),
        points: points,
        color: Colors.black,
        width: 2);

    _zoomToFitMarkersAndPolyline();

    return polyline;
  }

  void _zoomToFitMarkersAndPolyline() async {
    if (mapsController == null) return;
    final pointA = markers.first.position;
    final pointB = markers.last.position;

    // Define bounds
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        pointA.latitude < pointB.latitude ? pointA.latitude : pointB.latitude,
        pointA.longitude < pointB.longitude
            ? pointA.longitude
            : pointB.longitude,
      ),
      northeast: LatLng(
        pointA.latitude > pointB.latitude ? pointA.latitude : pointB.latitude,
        pointA.longitude > pointB.longitude
            ? pointA.longitude
            : pointB.longitude,
      ),
    );

    // Update camera to fit the bounds
    CameraUpdate update =
        CameraUpdate.newLatLngBounds(bounds, 50); // 50 is padding
    await mapsController!.animateCamera(update);
  }

  double latitude(Prediction? value) => double.parse(value?.lat ?? "0.0");
  double longitude(Prediction? value) => double.parse(value?.lng ?? "0.0");

  location() {
    return CameraPosition(
      target: LatLng(double.parse(origin?.lat ?? "0.0"),
          double.parse(origin?.lng ?? "0.0")),
      zoom: 14.4746,
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;
      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(
        (lat / 1E5),
        (lng / 1E5),
      ));
    }
    return polyline;
  }
}
