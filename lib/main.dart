import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/providers/questions_provider.dart';
import 'package:quiz_app_assignment/screens/front_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestionsProvider(),
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const FrontScreen(),
      ),
    );
  }
}
