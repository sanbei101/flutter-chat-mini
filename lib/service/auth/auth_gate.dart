import 'package:flutter/material.dart';
import 'package:flutterchat/pages/home_page.dart';
import 'package:flutterchat/service/auth/login_or_register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  AuthGateState createState() => AuthGateState();
}

class AuthGateState extends State<AuthGate> {
  late Future<bool> _initialLoginCheckFuture;

  @override
  void initState() {
    super.initState();
    _initialLoginCheckFuture = _checkInitialLoginStatus();
  }

  Future<bool> _checkInitialLoginStatus() async {
    final session = Supabase.instance.client.auth.currentSession;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = session != null;
    await prefs.setBool('isLoggedIn', isLoggedIn);
    return isLoggedIn;
  }

  Future<void> _signOut() async {
    await Supabase.instance.client.auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _initialLoginCheckFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // 使用StreamBuilder来监听认证状态的变化
            return StreamBuilder<AuthState>(
              stream: Supabase.instance.client.auth.onAuthStateChange,
              builder: (context, authSnapshot) {
                if (authSnapshot.hasData) {
                  final authState = authSnapshot.data!;
                  if (authState.event == AuthChangeEvent.signedIn) {
                    // 用户已登录，显示HomePage
                    return HomePage(signOut: _signOut);
                  }
                }
                // 用户未登录或登出，显示LoginOrRegister
                return const LoginOrRegister();
              },
            );
          }
        },
      ),
    );
  }
}
