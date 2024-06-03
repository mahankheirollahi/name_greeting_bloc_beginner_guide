import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'greeting_event.dart';
part 'greeting_state.dart';

class GreetingBloc extends Bloc<GreetingEvent, GreetingState> {
  GreetingBloc() : super(GreetingInitial()) {
    on<GreetingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
