import 'package:flutter/material.dart';

// MyTextfiled 是一个无状态的小部件，它显示一个带有提示文本的文本输入框。
class MyTextfiled extends StatelessWidget {
  // 提示文本，显示在文本输入框中。
  final String hintText;

  // 是否隐藏文本输入（用于密码输入框）。
  final bool obscureText;

  // 文本输入框的控制器，用于获取和设置文本输入框的值。
  final TextEditingController controller;

  // 构造函数，接受提示文本、是否隐藏文本和控制器作为参数。
  const MyTextfiled(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 设置文本输入框的左右内边距。
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        // 是否隐藏文本输入。
        obscureText: obscureText,
        // 设置文本输入框的控制器。
        controller: controller,
        // 设置文本输入框的装饰，包括边框、背景颜色和提示文本。
        decoration: InputDecoration(
          // 未聚焦时的边框样式。
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          // 聚焦时的边框样式。
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          // 文本输入框的背景颜色。
          fillColor: Theme.of(context).colorScheme.secondary,
          // 是否填充背景颜色。
          filled: true,
          // 提示文本。
          hintText: hintText,
          // 提示文本的样式。
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
