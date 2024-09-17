import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  HomeBloc() : super(const HomeStates()) {
    on<ButtonEnabledEvent>(enableButton);
    on<ButtonDisabledEvent>(disableButton);
  }

  enableButton(ButtonEnabledEvent event, Emitter<HomeStates> emit) {
    emit(
      state.copWith(
        isDisabled: false,
      ),
    );
  }

  disableButton(ButtonDisabledEvent event, Emitter<HomeStates> emit) {
    emit(
      state.copWith(
        isDisabled: true,
      ),
    );
  }
}
