import 'dart:async';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'greeting_event.dart';
part 'greeting_state.dart';

class GreetingBloc extends Bloc<GreetingEvent, GreetingState> {
  GreetingBloc() : super(GreetingState.initial()) {
    on<GetName>(_getName);
    on<GetFavoriteColor>(_getFavoriteColor);
  }

  FutureOr<void> _getName(GetName event, Emitter<GreetingState> emit) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _getFavoriteColor(
      GetFavoriteColor event, Emitter<GreetingState> emit) {
    emit(state.copyWith(favoriteColor: event.favoriteColor));
  }
}
