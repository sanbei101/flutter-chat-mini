import 'package:flutter/material.dart';
import 'package:flutterchat/service/auth/auth_gate.dart';
import 'package:flutterchat/themes/light_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://uxdfqphdyfpxrgguenpe.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV4ZGZxcGhkeWZweHJnZ3VlbnBlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI1MDA3NDcsImV4cCI6MjAzODA3Njc0N30.3iGoqy9YU6PbnOpSvdXGkK38PQjJbBLFK1SURKOjTG4';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: lightMode,
    );
  }
}
