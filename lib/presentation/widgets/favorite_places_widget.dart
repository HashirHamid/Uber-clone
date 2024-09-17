import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uber_clone/config/router/route_names.dart';
import 'package:uber_clone/data/dummy/dummy_favorite_places.dart';
import 'package:uber_clone/logic/blocs/home/home_bloc.dart';
import 'package:uber_clone/logic/blocs/maps/maps_bloc.dart';

class FavoritePlacesWidget extends StatelessWidget {
  const FavoritePlacesWidget({super.key, required this.isFromHome});
  final bool isFromHome;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade200,
              ),
          itemCount: dummyPlaces.length,
          itemBuilder: (context, index) {
            final place = dummyPlaces[index];
            return ListTile(
              onTap: () async {
                context.read<MapsBloc>().origin = place.latlng;
                context.read<MapsBloc>().add(InitialMapEvent());
                context.read<MapsBloc>().add(AddOriginMarkerEvent());
                await Permission.location.request();
                // ignore: use_build_context_synchronously
                if (isFromHome) {
                  await context.push(RouteNames.mapRoute).then((value) =>
                      context.read<HomeBloc>().add(ButtonDisabledEvent()));
                }
              },
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  place.icon,
                  color: Colors.white,
                ),
              ),
              title: Text(
                place.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                place.subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            );
          }),
    );
  }
}
