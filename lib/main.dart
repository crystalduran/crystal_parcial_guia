import 'package:flutter/material.dart';
import 'package:crystal_examen_2/screens/registro_evento_screen.dart';
import 'package:crystal_examen_2/screens/eventos_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: EventosScreen(),
    );
  }
}


