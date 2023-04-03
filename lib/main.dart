import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joke_me/features/jokes_list/presentation/screens/jokes_list_screen.dart';
import "package:joke_me/injector.dart" as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.sairaCondensedTextTheme(),
      ),
      home: const JokesListScreen(),
    );
  }
}
