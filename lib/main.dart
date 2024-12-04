import 'package:e_library/views/boxes.dart';
import 'package:e_library/views/login.dart';
import 'package:e_library/views/story.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Hive
  await Hive.initFlutter();

  // Registrasi adapter jika diperlukan (untuk objek custom seperti Story)
  Hive.registerAdapter(StoryAdapter());

  // Membuka box sebelum digunakan
  await Hive.openBox<Story>(HiveBoxes.story);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electronic Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}