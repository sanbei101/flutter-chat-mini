import 'package:flutter/material.dart';
import 'package:flutterchat/service/auth/auth_service.dart';
import 'package:flutterchat/components/my_button.dart';
import 'package:flutterchat/components/my_textfiled.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.onTap});
  // 邮箱和密码的控制器
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;

  void register(BuildContext context) async {
    final authService = AuthService();
    // 检查密码和确认密码是否匹配
    if (_passwordController.text == _confirmPwController.text) {
      try {
        // 尝试使用邮箱和密码注册
        await authService.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        // 捕获任何错误并显示对话框
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            // 显示错误信息
            title: Text(e.toString()),
          ),
        );
      }
    }

    //如果密码不匹配
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("密码不匹配"),
        ),
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

            // 注册消息
            Text(
              "欢迎你注册",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 30),
            ),

            const SizedBox(
              height: 50,
            ),

            // 邮箱输入框
            MyTextfiled(
              controller: _emailController,
              hintText: "邮箱",
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            // 密码输入框
            MyTextfiled(
              controller: _passwordController,
              hintText: "密码",
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            // 确认密码输入框
            MyTextfiled(
              controller: _confirmPwController,
              hintText: "确认密码",
              obscureText: true,
            ),

            const SizedBox(
              height: 25,
            ),

            // 注册按钮
            MyButton(
              text: "注册",
              onTap: () => register(context),
            ),

            const SizedBox(
              height: 25,
            ),
            Row(
              // 将子组件在主轴上居中对齐
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 显示提示用户登录的文本
                Text(
                  "已经有账号?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // 可点击的登录文本
                GestureDetector(
                  // 当用户点击登录文本时，触发 onTap 回调
                  onTap: onTap,
                  child: Text(
                    "登入",
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
