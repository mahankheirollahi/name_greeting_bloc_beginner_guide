part of 'greeting_bloc.dart';

sealed class GreetingState extends Equatable {
  const GreetingState();
  
  @override
  List<Object> get props => [];
}

final class GreetingInitial extends GreetingState {}
