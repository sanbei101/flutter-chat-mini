import 'package:flutter/material.dart';
import 'package:flutterchat/service/auth/login_or_register.dart';
import 'package:flutterchat/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData &&
              snapshot.data!.event == AuthChangeEvent.signedIn) {
            return const HomePage();
          }

          // user is NOT logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
