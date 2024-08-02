import 'package:flutter/material.dart';
import 'package:flutterchat/service/auth/auth_service.dart';
import 'package:flutterchat/components/my_button.dart';
import 'package:flutterchat/components/my_textfiled.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.onTap});
  //email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;

  void register(BuildContext context) {
    final authService = AuthService();
    if (_passwordController.text == _confirmPwController.text) {
      try {
        authService.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    //如果密码不匹配
    else {
      showDialog(
        // ignore: use_build_context_synchronously
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
            //icon
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            //welcome back message
            Text(
              "register",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 30),
            ),

            const SizedBox(
              height: 50,
            ),

            //email field
            MyTextfiled(
              controller: _emailController,
              hintText: "email",
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            //password field
            MyTextfiled(
              controller: _passwordController,
              hintText: "password",
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            MyTextfiled(
              controller: _confirmPwController,
              hintText: "confirm password",
              obscureText: true,
            ),

            const SizedBox(
              height: 25,
            ),

            //register button
            MyButton(
              text: "register",
              onTap: () => register(context),
            ),

            const SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("login",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
