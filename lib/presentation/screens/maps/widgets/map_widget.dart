import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/logic/blocs/maps/maps_bloc.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapsBloc = context.read<MapsBloc>();
    return BlocBuilder<MapsBloc, MapsStates>(
      builder: (context, state) {
        print("REBUILT?");

        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: mapsBloc.location(),
          onMapCreated: (GoogleMapController controller) {
            mapsBloc.mapsController = controller;
          },
          markers: state.markers ?? {},
          polylines: state.polylines ?? {},
        );
      },
    );
  }
}
