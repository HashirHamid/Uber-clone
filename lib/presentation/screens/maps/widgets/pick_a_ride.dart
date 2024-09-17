import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/data/dummy/dummy_favorite_places.dart';
import 'package:uber_clone/logic/blocs/maps/maps_bloc.dart';

// ignore: must_be_immutable
class PickARide extends StatefulWidget {
  const PickARide({super.key});

  @override
  State<PickARide> createState() => _PickARideState();
}

class _PickARideState extends State<PickARide> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              onPressed: () {
                context.read<MapsBloc>().add(NoDestinationEvent());
              },
            ),
            Text(
              "Select a Ride - ${context.read<MapsBloc>().travelTime?.rows?[0].elements?[0].distance?.text}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: rideTypes.length,
            itemBuilder: (context, index) {
              final ride = rideTypes[index];
              final price = ((context
                          .read<MapsBloc>()
                          .travelTime
                          ?.rows?[0]
                          .elements?[0]
                          .duration!
                          .value) ??
                      0) *
                  1.5 *
                  ride.multiplier! /
                  100;
              print(ride.multiplier);
              return ListTile(
                leading: Image.network(ride.image ?? ""),
                onTap: () {
                  setState(() {
                    _selectedValue = index;
                  });
                },
                title: Text(ride.title ?? ""),
                selectedColor: Colors.black,
                selectedTileColor: Colors.grey.shade200,
                selected: _selectedValue == index ? true : false,
                subtitle: Text(
                  "${context.read<MapsBloc>().travelTime?.rows?[0].elements?[0].duration?.text} travel time",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                trailing: Text(
                  "\$$price",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          width: double.maxFinite,
          margin: const EdgeInsets.all(8),
          color: _selectedValue != null ? Colors.black : Colors.black54,
          child: Center(
            child: Text(
              _selectedValue != null
                  ? "Choose ${rideTypes[_selectedValue!].title}"
                  : "Choose",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
