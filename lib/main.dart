import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_greeting_bloc_beginner_guide/bloc/greeting_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => GreetingBloc(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.pink
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Name Greeting',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  label: const Text(
                    'Enter your name',
                    style: TextStyle(fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  context.read<GreetingBloc>().add(GetName(name: value));
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Favorite Color',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: colors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<GreetingBloc>()
                          .add(GetFavoriteColor(favoriteColor: color));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: color),
                      child:
                          context.watch<GreetingBloc>().state.favoriteColor ==
                                  color
                              ? const Icon(
                                  Icons.done_rounded,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : const SizedBox(),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
