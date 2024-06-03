import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_greeting_bloc_beginner_guide/bloc/greeting_bloc.dart';
import 'package:name_greeting_bloc_beginner_guide/second_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => GreetingBloc(),
      child: const MaterialApp(
        home: MainApp(),
        debugShowCheckedModeBanner: false,
      ),
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
    return Scaffold(
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
            textfield(context),
            const SizedBox(height: 20),
            const Text(
              'Favorite Color',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            favoriteColor(colors, context),
            const SizedBox(height: 30),
            submitButton(context)
          ],
        ),
      ),
    );
  }

  TextField textfield(BuildContext context) {
    return TextField(
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
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.all(
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
    );
  }

  Row favoriteColor(List<MaterialColor> colors, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () {
            // Adding GetFavoriteColor Event to the stream and passing the user's favorite color
            context
                .read<GreetingBloc>()
                .add(GetFavoriteColor(favoriteColor: color));
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            // Checking if the user's chosed color is the rendered color on the scrren, If it was the same rebuild the ui and show selected done icon
            child: context.watch<GreetingBloc>().state.favoriteColor == color
                ? const Icon(
                    Icons.done_rounded,
                    color: Colors.white,
                    size: 30,
                  )
                : const SizedBox(),
          ),
        );
      }).toList(),
    );
  }

  SizedBox submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          // Adding GetName Event to the stream and passing the user's name
          context.read<GreetingBloc>().add(GetName(name: controller.text));
          if (controller.text.isNotEmpty) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SecondScreen();
            }));
          } else {
            return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Name field is required'),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Make sure you enter your name'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }
        },
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}