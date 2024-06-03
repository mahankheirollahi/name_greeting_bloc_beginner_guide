part of 'greeting_bloc.dart';

sealed class GreetingEvent extends Equatable {
  const GreetingEvent();

  @override
  List<Object> get props => [];
}

class GetName extends GreetingEvent {
  final String name;
  const GetName({required this.name});
}

class GetFavoriteColor extends GreetingEvent {
  final Color favoriteColor;
  const GetFavoriteColor({required this.favoriteColor});
}
