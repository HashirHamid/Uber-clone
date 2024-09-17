part of 'maps_bloc.dart';

class MapsStates extends Equatable {
  const MapsStates(
      {this.destinationEntered = false, this.markers, this.polylines});
  final bool destinationEntered;
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;

  MapsStates copyWith(
      {bool? destinationEntered,
      Set<Marker>? markers,
      Set<Polyline>? polylines}) {
    return MapsStates(
      destinationEntered: destinationEntered ?? this.destinationEntered,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }

  @override
  List<Object> get props => [
        destinationEntered,
      ];
}
