import 'package:flutter/material.dart';

// MyButton 是一个无状态的小部件，它显示一个带有文本的按钮，并在点击时触发 onTap 回调。
class MyButton extends StatelessWidget {
  // 构造函数，接受文本和点击回调函数作为参数。
  const MyButton({super.key, required this.text, required this.onTap});

  // 按钮上显示的文本。
  final String text;

  // 按钮点击时触发的回调函数。
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 当按钮被点击时，触发 onTap 回调。
      onTap: onTap,
      child: Container(
        // 设置按钮的装饰，包括背景颜色和圆角边框。
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        // 设置按钮的内边距。
        padding: const EdgeInsets.all(25),
        // 设置按钮的外边距。
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          // 在按钮的中心显示文本。
          child: Text(text),
        ),
      ),
    );
  }
}
