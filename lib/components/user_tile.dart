import 'package:flutter/material.dart';

// UserTile 是一个无状态的小部件，它显示一个带有图标和文本的容器。
class UserTile extends StatelessWidget {
  // 构造函数，接受文本和点击回调函数作为参数。
  const UserTile({super.key, required this.text, this.onTap});

  // 容器内显示的文本。
  final String text;

  // 容器点击时触发的回调函数。
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 当容器被点击时，触发 onTap 回调。
      onTap: onTap,
      child: Container(
        // 设置容器的装饰，包括背景颜色和圆角边框。
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        // 设置容器的外边距。
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        // 设置容器的内边距。
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // 显示一个用户图标。
            const Icon(Icons.person),
            // 设置图标和文本之间的间距。
            const SizedBox(width: 20),
            // 显示文本。
            Text(text),
          ],
        ),
      ),
    );
  }
}
