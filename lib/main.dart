import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_greeting_bloc_beginner_guide/bloc/greeting_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => GreetingBloc(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(),
    );
  }
}
