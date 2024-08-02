import 'package:flutter/material.dart';

/// 聊天气泡组件
class ChatBubble extends StatelessWidget {
  /// 构造函数，接收消息内容和是否为发送者的标志
  const ChatBubble({super.key, required this.message, required this.isSender});

  /// 消息内容
  final String message;

  /// 是否为发送者
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        /// 根据是否为发送者设置背景颜色
        color: isSender ? Colors.green : Colors.grey,

        /// 设置圆角边框
        borderRadius: BorderRadius.circular(10),
      ),

      /// 设置内边距
      padding: const EdgeInsets.all(16),

      /// 设置外边距
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,

        /// 设置文本样式
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
