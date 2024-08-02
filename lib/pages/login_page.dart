import 'package:flutter/material.dart';
import 'package:flutterchat/service/auth/auth_service.dart';
import 'package:flutterchat/components/my_button.dart';
import 'package:flutterchat/components/my_textfiled.dart';

class LoginPage extends StatelessWidget {
  //email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginPage({super.key, required this.onTap});
  // fuction to register page
  final void Function()? onTap;

  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
    // catch any errors
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
              "welcome back",
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
              height: 25,
            ),

            //login button
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),

            const SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register",
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
