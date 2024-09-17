part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

final class InitialEvent extends HomeEvent {}

final class ButtonDisabledEvent extends HomeEvent {}

final class ButtonEnabledEvent extends HomeEvent {}
