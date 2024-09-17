import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/logic/blocs/maps/maps_bloc.dart';
import 'package:uber_clone/presentation/screens/maps/widgets/add_destination.dart';
import 'package:uber_clone/presentation/screens/maps/widgets/map_widget.dart';
import 'package:uber_clone/presentation/screens/maps/widgets/pick_a_ride.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 2,
              child: const MapWidget(),
            ),
            BlocBuilder<MapsBloc, MapsStates>(
              builder: (context, state) {
                return SizedBox(
                    height: size.height / 2,
                    child: state.destinationEntered
                        ? PickARide()
                        : const AddDestination());
              },
            ),
          ],
        ),
      ),
    );
  }
}
