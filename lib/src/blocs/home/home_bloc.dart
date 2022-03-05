import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeSetClockEvent>(_setClock);
  }

  void _setClock(HomeSetClockEvent event, Emitter<HomeState> emit) {

  }
}
