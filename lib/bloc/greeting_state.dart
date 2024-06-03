part of 'greeting_bloc.dart';

class GreetingState extends Equatable {
  final String name;
  final Color favoriteColor;
  const GreetingState({required this.name, required this.favoriteColor});
  @override
  List<Object> get props => [name, favoriteColor];
  GreetingState copyWith({
    String? name,
    Color? favoriteColor,
  }) {
    return GreetingState(
      name: name ?? this.name,
      favoriteColor: favoriteColor ?? this.favoriteColor,
    );
  }

  factory GreetingState.initial() {
    return const GreetingState(name: '', favoriteColor: Colors.white);
  }
}
