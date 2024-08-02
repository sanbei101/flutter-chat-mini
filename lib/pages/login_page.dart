import 'package:flutter/material.dart';
import 'package:flutterchat/service/auth/auth_service.dart';
import 'package:flutterchat/components/my_button.dart';
import 'package:flutterchat/components/my_textfiled.dart';

class LoginPage extends StatelessWidget {
  // 邮箱和密码的控制器
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 构造函数，接受一个点击回调函数
  LoginPage({super.key, required this.onTap});

  // 跳转到注册页面的回调函数
  final void Function()? onTap;

  // 登录函数
  void login(BuildContext context) async {
    // 认证服务
    final authService = AuthService();

    // 尝试登录
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
    // 捕获任何错误
    catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ), // AlertDialog
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 图标
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            // 欢迎回来消息
            Text(
              "welcome back",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 30),
            ),

            const SizedBox(
              height: 50,
            ),

            // 邮箱输入框
            MyTextfiled(
              controller: _emailController,
              hintText: "email",
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            // 密码输入框
            MyTextfiled(
              controller: _passwordController,
              hintText: "password",
              obscureText: true,
            ),

            const SizedBox(
              height: 25,
            ),

            // 登录按钮
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),

            const SizedBox(
              height: 25,
            ),
            Row(
              // 将子组件在主轴上居中对齐
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 显示提示用户注册的文本
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // 可点击的注册文本
                GestureDetector(
                  // 当用户点击注册文本时，触发 onTap 回调
                  onTap: onTap,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
