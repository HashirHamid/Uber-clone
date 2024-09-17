part of 'home_bloc.dart';

class HomeStates extends Equatable {
  const HomeStates({this.isDisabled = true});
  final bool isDisabled;

  HomeStates copWith({
    bool? isDisabled,
  }) {
    return HomeStates(
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }

  @override
  List<Object?> get props => [isDisabled];
}
