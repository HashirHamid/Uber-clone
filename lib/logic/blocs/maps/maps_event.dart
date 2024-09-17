part of 'maps_bloc.dart';

@immutable
abstract class MapsEvent {}

final class InitialMapEvent extends MapsEvent {}

final class NoDestinationEvent extends MapsEvent {}

final class DestinationEvent extends MapsEvent {}

final class AddOriginMarkerEvent extends MapsEvent {}

final class AddDestinationMarkerEvent extends MapsEvent {}
