import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/logic/blocs/home/home_bloc.dart';
import 'package:uber_clone/logic/blocs/maps/maps_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
  BlocProvider<MapsBloc>(create: (context) => MapsBloc()),
];
