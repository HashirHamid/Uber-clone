import 'package:go_router/go_router.dart';
import 'package:uber_clone/config/router/route_names.dart';
import 'package:uber_clone/presentation/screens/home/home_screen.dart';
import 'package:uber_clone/presentation/screens/maps/maps_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteNames.homeRoute,
  routes: [
    GoRoute(
      path: RouteNames.homeRoute,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.mapRoute,
      builder: (context, state) => const MapsScreen(),
    ),
    // GoRoute(
    //   path: "home",
    //   builder: (context, state) => const HomeScreen(),
    // ),
  ],
);
