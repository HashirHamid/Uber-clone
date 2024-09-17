import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uber_clone/config/router/route_names.dart';
import 'package:uber_clone/config/utils/assets.dart';
import 'package:uber_clone/logic/blocs/home/home_bloc.dart';
import 'package:uber_clone/logic/blocs/maps/maps_bloc.dart';
import 'package:uber_clone/presentation/screens/home/widgets/home_button_widget.dart';
import 'package:uber_clone/presentation/widgets/favorite_places_widget.dart';
import 'package:uber_clone/presentation/widgets/google_places_textfield_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              Assets.uberLogo,
              height: 100,
              width: 100,
            ),
            GooglePlacesTextFieldWidget(
              placeHolderText: "Where From?",
              controller: controller,
              disableButtonHandler: () {
                if (controller.text.isNotEmpty) {
                  context.read<HomeBloc>().add(ButtonEnabledEvent());
                } else {
                  context.read<HomeBloc>().add(ButtonDisabledEvent());
                }
              },
              getPlaceDetailHandler: (prediction) {
                context.read<MapsBloc>().origin = prediction;
                context.read<MapsBloc>().add(AddOriginMarkerEvent());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<HomeBloc, HomeStates>(
              bloc: context.read<HomeBloc>(),
              builder: (context, state) {
                return Row(
                  children: [
                    HomeButtonWidget(
                      icon: Assets.carLogo,
                      isDisabled: state.isDisabled,
                      title: "Get a ride",
                      function: () async {
                        await Permission.location.request();
                        // ignore: use_build_context_synchronously
                        await context.push(RouteNames.mapRoute).then((value) =>
                            context
                                .read<HomeBloc>()
                                .add(ButtonDisabledEvent()));
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    HomeButtonWidget(
                      icon: Assets.foodLogo,
                      isDisabled: state.isDisabled,
                      title: "Order food",
                      function: () {},
                    ),
                  ],
                );
              },
            ),
            const FavoritePlacesWidget(isFromHome: true)
          ],
        ),
      )),
    );
  }
}
