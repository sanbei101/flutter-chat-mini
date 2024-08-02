import 'package:flutter/material.dart'; // 导入Flutter的Material库
import 'package:flutterchat/service/auth/login_or_register.dart'; // 导入自定义的登录或注册页面
import 'package:flutterchat/pages/home_page.dart'; // 导入自定义的主页
import 'package:supabase_flutter/supabase_flutter.dart'; // 导入Supabase的Flutter库

// 定义一个无状态组件AuthGate
class AuthGate extends StatelessWidget {
  const AuthGate({super.key}); // 构造函数，接收一个可选的key参数

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 返回一个Scaffold小部件
      body: StreamBuilder<AuthState>(
        // 使用StreamBuilder监听认证状态的变化
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          // 构建UI
          // 如果用户已登录
          if (snapshot.hasData &&
              snapshot.data!.event == AuthChangeEvent.signedIn) {
            return HomePage(); // 返回主页
          }

          // 如果用户未登录
          else {
            return const LoginOrRegister(); // 返回登录或注册页面
          }
        },
      ),
    );
  }
}
