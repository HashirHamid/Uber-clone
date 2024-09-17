import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/logic/blocs/maps/maps_bloc.dart';
import 'package:uber_clone/presentation/widgets/favorite_places_widget.dart';
import 'package:uber_clone/presentation/widgets/google_places_textfield_widget.dart';

class AddDestination extends StatefulWidget {
  const AddDestination({super.key});

  @override
  State<AddDestination> createState() => _AddDestinationState();
}

class _AddDestinationState extends State<AddDestination> {
  TextEditingController controller = TextEditingController();

  FocusNode keyboardFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    MapsBloc mapsBloc = context.read<MapsBloc>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text(
            "Good Morning!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          GooglePlacesTextFieldWidget(
            placeHolderText: "Where To?",
            controller: controller,
            boxDecoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5)),
            getPlaceDetailHandler: (prediction) {
              mapsBloc.destination = prediction;

              mapsBloc.add(AddDestinationMarkerEvent());
            },
          ),
          const FavoritePlacesWidget(
            isFromHome: false,
          )
        ],
      ),
    );
  }
}
