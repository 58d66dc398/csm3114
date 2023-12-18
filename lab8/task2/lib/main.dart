import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lab8/view_movies.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(MaterialApp(
    title: 'My Movies',
    theme: ThemeData(useMaterial3: true),
    home: const Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => const MovieList();
}
