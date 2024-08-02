import 'package:flutter/material.dart';
import 'package:flutterchat/components/chat_bubble.dart';
import 'package:flutterchat/components/my_textfiled.dart';
import 'package:flutterchat/service/chat/chat_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverEmail});

  // 接收者的邮箱
  final String receiverEmail;

  // 发送者的邮箱，从 Supabase 客户端的当前用户信息中获取
  final String senderEmail = Supabase.instance.client.auth.currentUser!.email!;

  // 消息输入框的控制器
  final TextEditingController messageController = TextEditingController();

  // 聊天服务实例
  final ChatService chatService = ChatService();

  void sendMessage() {
    // 获取消息内容
    final message = messageController.text;

    // 发送消息
    chatService.sendMessage(receiverEmail, message);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail), // 显示接收者的邮箱作为标题
        backgroundColor: Colors.transparent, // 设置背景颜色为透明
        foregroundColor: Colors.grey, // 设置前景颜色为灰色
        elevation: 0, // 移除阴影
      ),
      body: Column(
        children: [
          _buildMessageList(), // 构建消息列表
          _buildInputField(), // 构建输入框
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatService.getMessagesStream(senderEmail, receiverEmail),
      builder: (context, snapshot) {
        // 处理错误情况
        if (snapshot.hasError) {
          return const Text("加载错误");
        }
        // 处理加载情况
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("加载中...");
        }
        // 返回消息列表视图
        if (snapshot.hasData) {
          return ListView(
            children:
                snapshot.data!.map((user) => _buildMessageItem(user)).toList(),
          );
        } else {
          return const Text("没有数据");
        }
      },
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    //判断是否为当前用户
    final isCurrentUser = data["senderEmail"] == senderEmail;
    // 如果发送者是当前用户，将消息对齐到右边，否则对齐到左边
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment, // 设置容器的对齐方式
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isSender: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50), // 设置底部内边距
      child: Row(
        children: [
          Expanded(
            child: MyTextfiled(
              controller: messageController, // 绑定消息输入框的控制器
              hintText: '输入消息', // 输入框的提示文本
              obscureText: false,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green, // 设置按钮背景颜色为绿色
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25), // 设置右边距
            child: IconButton(
              icon: const Icon(
                Icons.arrow_upward, // 设置按钮图标为向上箭头
                color: Colors.white, // 设置图标颜色为白色
              ),
              onPressed: sendMessage, // 绑定发送消息的回调函数
            ),
          ),
        ],
      ),
    );
  }
}
