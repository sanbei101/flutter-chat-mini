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
  bool _isLoggedIn = false; // 用于存储用户是否已登录的状态

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // 初始化时检查登录状态
  }

  // 检查用户的登录状态并保存登录状态
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); // 获取SharedPreferences实例
    setState(() {
      _isLoggedIn =
          prefs.getBool('isLoggedIn') ?? false; // 获取存储的登录状态，如果没有则默认为false
    });

    if (_isLoggedIn) {
      final user = Supabase.instance.client.auth.currentUser; // 获取当前Supabase用户
      if (user == null) {
        setState(() {
          _isLoggedIn = false; // 如果Supabase中没有用户信息，则更新状态为未登录
          prefs.setBool('isLoggedIn', false); // 同时更新SharedPreferences中的登录状态
        });
      }
    }
  }

  // 用户登出的方法
  Future<void> _signOut() async {
    await Supabase.instance.client.auth.signOut(); // 调用Supabase的signOut方法
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false); // 更新SharedPreferences中的登录状态为未登录
    setState(() {
      _isLoggedIn = false; // 更新组件状态
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange, // 监听认证状态变化的流
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.event == AuthChangeEvent.signedIn) {
            SharedPreferences.getInstance().then(
                (prefs) => prefs.setBool('isLoggedIn', true)); // 如果用户已登录，保存登录状态
            return HomePage(signOut: _signOut); // 返回主页，并传递登出方法
          } else {
            SharedPreferences.getInstance().then((prefs) =>
                prefs.setBool('isLoggedIn', false)); // 如果用户未登录，保存未登录状态
            return const LoginOrRegister(); // 返回登录或注册页面
          }
        },
      ),
    );
  }
}
